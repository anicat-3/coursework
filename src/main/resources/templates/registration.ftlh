<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
    <h4>Новый аккаунт</h4>
    ${message?if_exists}
    <@l.login "/registration" true/>
</@c.page>