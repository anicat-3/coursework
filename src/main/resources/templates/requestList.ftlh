<#setting date_format="yyyy/MM/dd">
<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">
<@c.page>
    <div class="col-auto mr-auto">
        <h5>Список заявок</h5>
    </div>
    <#if requests?has_content>
        <table class="table table-striped table-hover table-sm">
            <thead class="table-secondary">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Услуга</th>
                <th scope="col">Дата подачи</th>
                <th scope="col">Состояние</th>
                <th scope="col"></th>
                <#if isEmployee>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </#if>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <#list requests as request>
                <tr>
                    <td scope="row">${request_index + 1}</td>
                    <td><#if request.deposit??>Вклад "${request.deposit.name}"</#if></td>
                    <td>${request.date?date?string('yyyy-MM-dd')}</td>
                    <td>
                        <#if !request.approved??>
                            На рассмотрении
                            <#else>
                                ${request.approved?string("Одобрено", "Отказано")}
                        </#if>
                    </td>
                    <#if !isEmployee>
                        <td>
                            <form action="/request/${user.id}/${request.id}" method="post">
                                <input type="hidden" name="userId" value="${user.id}" />
                                <input type="hidden" name="requestId" value="${request.id}"/>
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-outline-info" ${(request.approved??)?string("disabled", "")}>Отменить</button>
                            </form>
                        </td>
                    </#if>
                    <#if isEmployee>
                        <td>
                            <form action="request/approve/${request.id}" method="post">
                                <input type="hidden" name="requestId" value="${request.id}"/>
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-outline-success" ${(request.approved??)?string("disabled", "")}>Одобрить</button>
                            </form>
                        </td>
                        <td>
                            <form action="request/reject/${request.id}" method="post">
                                <input type="hidden" name="requestId" value="${request.id}"/>
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-outline-danger" ${(request.approved??)?string("disabled", "")}>Отклонить</button>
                            </form>
                        </td>
                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <div>Список заявок пуст!</div>
    </#if>
</@c.page>