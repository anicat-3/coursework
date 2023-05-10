<#import "parts/common.ftlh" as c>
<@c.page>
    <h5>Редактирование пользователя</h5>
    <form action="/user" method="post">
        <input type="text" name="username" value="${user.username}"/><br>
        <fieldset>
            <#list roles as role>
                <label><input type="radio"
                              name="role" value="${role}" ${user.role?contains(role)?string("checked","")}>${role}</input></label>
                <br>
            </#list>
        </fieldset>
        <input type="hidden" name="user" value="${user.id}"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">Save</button>
    </form>
</@c.page>