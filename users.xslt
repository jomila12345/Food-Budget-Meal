<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <!-- Registration form -->
    <h2>Register</h2>
    <form id="registerForm">
        First Name: <input type="text" name="regFirstName"/><br/>
        Last Name: <input type="text" name="regLastName"/><br/>
        Email: <input type="email" name="regEmail"/><br/>
        Password: <input type="password" name="regPassword"/><br/>
        <button type="submit">Register</button>
    </form>

    <!-- Login form -->
    <h2>Login</h2>
    <form id="loginForm">
        Email: <input type="text" name="loginEmail"/><br/>
        Password: <input type="password" name="loginPassword"/><br/>
        <button type="submit">Login</button>
    </form>
</xsl:template>

</xsl:stylesheet>
