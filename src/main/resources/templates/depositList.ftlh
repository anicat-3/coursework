<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">
<@c.page>
    <div class="form-group row justify-content-between">
        <div class="col-auto mr-auto">
            <h5>Список вкладов</h5>
        </div>
        <#if isEmployee>
            <div class="col-auto">
                <a class="btn btn-outline-dark" href="/deposit/add" role="button">Добавить</a>
            </div>
        </#if>
    </div>
    <#if deposits?has_content>
        <table class="table table-striped table-hover table-sm">
            <thead class="table-secondary">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Название</th>
                <th scope="col">Тип</th>
                <th scope="col">Процентная ставка</th>
                <th scope="col">Валюта</th>
                <th scope="col"></th>
                <#if isEmployee>
                    <th scope="col"></th>
                </#if>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <#list deposits as deposit>
                <#if deposit.type == "DEMAND">
                    <#assign
                    type = "До востребования"
                    >
                </#if>
                <#if deposit.type == "TIME_REVOCABLE">
                    <#assign
                    type = "Срочный (отзывной)"
                    >
                </#if>
                <#if deposit.type == "TIME_IRREVOCABLE">
                    <#assign
                    type = "Срочный (безотзывной)"
                    >
                </#if>
                <tr>
                    <td scope="row">${deposit_index + 1}</td>
                    <td>${deposit.name}</td>
                    <td>${type}</td>
                    <td>${deposit.interestRate}</td>
                    <td><#list deposit.currency as c>${c}<#sep>, </#list></td>
                    <td>
                        <form action="/deposit/${deposit.id}" method="get">
                            <input type="hidden" name="depositId" value="${deposit.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-outline-info">Подробнее</button>
                        </form>
                    </td>
                    <#if isEmployee>
                        <td>
                            <form action="/deposit/${deposit.id}" method="post">
                                <input type="hidden" name="depositId" value="${deposit.id}"/>
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-outline-danger">Удалить</button>
                            </form>
                        </td>
                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <div>Список вкладов пуст!</div>
    </#if>
</@c.page>