<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Output method to specify HTML -->
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Root template -->
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Ordering Page</title>
                <style>
                    body {
                        font-family: "Comic Sans MS", cursive;
                        margin: 0;
                        padding: 0;
                    }
                    h2 {
                        color: saddlebrown;
                    }
                    header {
                        background-color: lightgoldenrodyellow;
                        color: saddlebrown;
                        padding: 10px 0;
                        text-align: center;
                    }
                    .container {
                        max-width: 800px;
                        margin: 20px auto;
                        padding: 0 20px;
                    }
                    .menu-item {
                        border-bottom: 1px solid #ccc;
                        padding: 10px 0;
                        display: grid;
                        grid-template-columns: auto 1fr auto;
                        justify-content: space-between;
                        align-items: center;
                    }
                    .menu-item:last-child {
                        border-bottom: none;
                    }
                    .menu-item button {
                        background-color: whitesmoke;
                        color: saddlebrown;
                        border: none;
                        padding: 5px 10px;
                        cursor: pointer;
                    }
                    .order-list {
                        margin-top: 20px;
                    }
                    .order-item {
                        margin-bottom: 10px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }
                    .order-item button {
                        background-color: #f00;
                    }
                    .total {
                        margin-top: 20px;
                        font-weight: bold;
                    }
                    .order-placed {
                        text-align: center;
                        font-weight: bold;
                        font-size: 20px;
                        color: green;
                    }
                    button[type="submit"] {
                        width: 100%;
                        padding: 10px;
                        background-color: saddlebrown;
                        color: white;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                    }
                    img {
                        width: 150px;
                        height: 100px;
                    }
                    button:hover {
                        color: red;
                    }
                </style>
            </head>
            <body>
                <header>
                    <h1>Order Now</h1>
                </header>
                <div class="container">
                    <h2>Menu</h2>
                    <div class="menu">
                        <xsl:for-each select="orderPage/menu/menuItem">
                            <div class="menu-item">
                                <span><xsl:value-of select="name"/></span>
                                <span>₱<xsl:value-of select="price"/></span>
                                <button class="add-to-order">Add</button>
                                <img>
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="image"/>
                                    </xsl:attribute>
                                </img>
                            </div>
                        </xsl:for-each>
                    </div>
                    <h2>Your Order</h2>
                    <div class="order-list">
                        <xsl:for-each select="orderPage/order/orderItem">
                            <div class="order-item">
                                <span><xsl:value-of select="name"/></span>
                                <span>₱<xsl:value-of select="price"/></span>
                                <button class="remove-from-order">Remove</button>
                            </div>
                        </xsl:for-each>
                    </div>
                    <div class="total">
                        Total: P<span><xsl:value-of select="orderPage/order/total"/></span>
                    </div>
                    <div id="order-placed" class="order-placed">
                        <xsl:if test="orderPage/order/orderPlaced='true'">Order Placed!</xsl:if>
                    </div>
                    <button type="submit">Submit</button>
                </div>

                <script>
                     document.addEventListener('DOMContentLoaded', function() {
		        const menuItems = document.querySelectorAll('.add-to-order');
		        const orderList = document.querySelector('.order-list');
		        const totalPriceDisplay = document.getElementById('total');
		        const orderPlacedMessage = document.getElementById('order-placed');
		        let totalPrice = 0;
		        let currentOrder = [];
		    
		        menuItems.forEach(item => {
		            item.addEventListener('click', function() {
		                const menuItem = this.parentNode.querySelector('span:first-child').innerText;
		                const price = parseFloat(this.parentNode.querySelector('span:nth-child(2)').innerText.replace('₱', ''));
		                totalPrice += price;
		                totalPriceDisplay.textContent = totalPrice.toFixed(2);
		    
		                currentOrder.push({ name: menuItem, price: price.toFixed(2) });
		    
		                const orderItem = document.createElement('div');
		                orderItem.classList.add('order-item');
		                orderItem.innerHTML = `
		                    <span>${menuItem}</span>
		                    <span>₱${price.toFixed(2)}</span>
		                    <button class="remove-from-order">Remove</button>
		                `;
		                orderList.appendChild(orderItem);
		            });
		        });
		    
		        orderList.addEventListener('click', function(e) {
		            if (e.target.classList.contains('remove-from-order')) {
		                const menuItem = e.target.parentNode.querySelector('span:first-child').innerText;
		                const price = parseFloat(e.target.parentNode.querySelector('span:nth-child(2)').innerText.replace('₱', ''));
		                totalPrice -= price;
		                totalPriceDisplay.textContent = totalPrice.toFixed(2);
		    
		                currentOrder = currentOrder.filter(item => item.name !== menuItem);
		                e.target.parentNode.remove();
		            }
		        });
		    
		        document.querySelector('button[type="submit"]').addEventListener('click', function() {
		            if (currentOrder.length === 0) {
		                alert('No items in the order.');
		                return;
		            }
		            console.log('Current Order:', currentOrder); // Debugging line
		            localStorage.setItem('savedOrder', JSON.stringify(currentOrder));
		            orderPlacedMessage.style.display = 'block';
		        });
		    });
                </script>
                <a href="saved_Order.html">View Saved Order</a>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
