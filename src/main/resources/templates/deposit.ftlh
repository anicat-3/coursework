<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<@c.page>
    <div class="container">
        <#if deposit??>
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

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Название вклада:</label>
                <label class="col-sm-4 col-form-label">${deposit.name}</label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Тип вклада:</label>
                <label class="col-sm-4 col-form-label">
                    <#if deposit.type??>
                        ${type}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Процентная ставка:</label>
                <label class="col-sm-4 col-form-label">
                    <#if deposit.interestRate??>
                        До ${deposit.interestRate}% годовых
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Валюта вклада:</label>
                <label class="col-sm-4 col-form-label">
                    <#if deposit.currency??>
                        <#list deposit.currency as c>${c}<#sep>, </#list>
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Ограничения по сумме вклада:</label>
                <label class="col-sm-4 col-form-label">
                    От <#if deposit.amountMin??>
                        ${deposit.amountMin}
                    </#if>
                    <#if deposit.currency??>
                        <#list deposit.currency as c>${c}<#sep> | </#list>
                    </#if>
                </label>
            </div>


            <#if deposit.termMin?? && deposit.termMax?? && deposit.termMin != deposit.termMax>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Ограничения по сроку вклада:</label>
                    <label class="col-sm-4 col-form-label">
                        От <#if deposit.termMin??>
                            ${deposit.termMin}
                        </#if>
                        до <#if deposit.termMax??>
                            ${deposit.termMax}
                        </#if>
                        месяцев
                    </label>
                </div>
            </#if>

            <div class="row align-self-start">
                <#if isEmployee>
                    <div class="col-2">
                        <form action="edit" method="get">
                            <input type="hidden" name="depositId" value="${deposit.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button class="btn btn-primary" type="submit">Редактировать</button>
                        </form>
                    </div>
                </#if>
                <#if !isEmployee && !isAdmin>
                    <div class="col-2">
                        <form action="/request/new" method="get">
                            <input type="hidden" name="depositId" value="${deposit.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button class="btn btn-primary" type="submit">Подать заявку</button>
                        </form>
                    </div>
                </#if>
                <div class="col-2">
                    <div class="col-auto">
                        <a class="btn btn-outline-dark" href="/deposit" role="button">Назад</a>
                    </div>
                </div>
            </div>
        </#if>
    </div>
</@c.page>