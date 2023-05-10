<#import "parts/common.ftlh" as c>
<@c.page>
    <h5>Список клиентов</h5>
    <#if clients?has_content>
        <table class="table table-striped table-hover table-sm">
            <thead class="table-secondary">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Фамилия</th>
                <th scope="col">Имя</th>
                <th scope="col">Отчество</th>
                <th scope="col">Гражданство</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <#list clients as client>
                <tr>
                    <td scope="row">${client_index + 1}</td>
                    <td>${client.surname}</td>
                    <td>${client.name}</td>
                    <td>${(client.patronymic??)?string("${client.patronymic}", "")}</td>
                    <td>${client.citizenship}</td>
                    <td>
                        <form action="/client/${client.id}" method="get">
                            <input type="hidden" name="clientId" value="${client.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-outline-info">Открыть</button>
                        </form>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <div>Список клиентов пуст!</div>
    </#if>
</@c.page>