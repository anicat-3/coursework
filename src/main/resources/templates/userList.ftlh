<#import "parts/common.ftlh" as c>
<@c.page>
    <h5>Список пользователей</h5>
    <#if users?has_content>
        <table class="table table-striped table-hover table-sm">
            <thead class="table-secondary">
            <tr>
                <th scope="col">#</th>
                <th scope="col" colspan="2">Имя пользователя</th>
                <th scope="col" colspan="1">Роль</th>
                <th scope="col" colspan="1">Детали</th>
                <th scope="col"></th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <#list users as user>
                <tr>
                    <td scope="row">${user_index + 1}</td>
                    <td colspan="2">${user.username}</td>
                    <td colspan="1">${user.role}</td>
                    <td colspan="1">
                        <#if user.role != "ADMIN" && user.role != "EMPLOYEE">
                            <form action="/profile/${user.id}" method="get">
                                <input type="hidden" name="userId" value="${user.id}"/>
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-outline-info">Открыть</button>
                            </form>
                        </#if>
                    </td>
                    <td colspan="1">
                        <form action="/user/${user.id}" method="get">
                            <input type="hidden" name="userId" value="${user.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-outline-warning">Редактировать</button>
                        </form>
                    </td>
                    <td colspan="1">
                        <form action="/user/${user.id}" method="post">
                            <input type="hidden" name="userId" value="${user.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-outline-danger">Удалить</button>
                        </form>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <div>Список пользователей пуст!</div>
    </#if>
</@c.page>