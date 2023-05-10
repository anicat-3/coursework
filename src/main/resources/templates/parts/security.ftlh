<#assign
    known = Session.SPRING_SECURITY_CONTEXT??
>
<#if known>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        id = user.getId()
        name = user.getUsername()
        isAdmin = user.isAdmin()
        isEmployee = user.isEmployee()
    >
<#else>
    <#assign
        name = "unknown"
        isAdmin = false
        isEmployee = false
    >
</#if>
