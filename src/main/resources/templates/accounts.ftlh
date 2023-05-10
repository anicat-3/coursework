<#setting date_format="yyyy/MM/dd">
<#import "parts/common.ftlh" as c>
<@c.page>
    <div class="form-group row justify-content-between">
        <div class="col-auto mr-auto">
            <h5>Сальдо банковского дня: ${.now?string.short}</h5>
        </div>
    </div>

    <#if accounts?? && accounts?has_content>
        <table class="table table-striped table-hover table-sm">
            <thead class="table-secondary">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Клиент</th>
                <th scope="col">Номер счета</th>
                <th scope="col">Тип</th>
                <th scope="col">Программа</th>
                <th scope="col">Сальдо счета</th>
                <th scope="col">Валюта</th>
                <th scope="col">Статус счета</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <#list accounts as account>
                <#if account.id == 1>
                    <#continue>
                </#if>
                <tr>
                    <td scope="row">${account.id}</td>
                    <td>${account.contract.request.user.userDescription.surname}</td>
                    <td>${account.accountNumber}</td>
                    <td>${account.contract.type}</td>
                    <td>${account.contract.request.deposit.name}</td>
                    <td>${account.amount?string["0.##"]}</td>
                    <td>${account.contract.request.currency}</td>
                    <td>${account.contract.opened?string("открыт", "закрыт")}</td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        <div>Список договоров пуст!</div>
    </#if>
</@c.page>