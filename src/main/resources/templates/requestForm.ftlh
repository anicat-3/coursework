<#import "parts/common.ftlh" as c>
<#import "parts/conditions.ftlh" as cond>
<link href="/static/conditions.css" rel="stylesheet">
<@c.page>
    <script>
        const selchange = () => {
            var id = document.getElementById('sel').value
            for (let i of document.getElementsByClassName("info")) {
                i.style.visibility = "collapse";
                i.style.display = "none"
            }
            document.getElementById(id).style.visibility = "visible";
            document.getElementById(id).style.display = "block";
        }
    </script>

    <form action="new" id="my" method="post">

        <h5>Заявка</h5>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Услуга:</label>
            <label class="col-sm-4 col-form-label"><#if deposit??>${deposit.name}</#if></label>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Валюта вклада:</label>
            <div class="col-sm-4">
                <select name="currency" id="sel" form="my" onchange="selchange();" required>
                    <option value="none" selected>Выберите валюту</option>
                    <#if deposit??>
                        <#list deposit.currency as currency>
                            <option value="${currency}">${currency}</option>
                        </#list>
                    </#if>
                </select>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Срок вклада и процентная ставка:</label>
            <div class="col-sm-4">
                <div class="conditions">
                    <div class="info byn-info" id="BYN">
                        <@cond.depositBYN type="${deposit.type}" termMin="${deposit.termMin}" termMax="${deposit.termMax}" />
                    </div>
                    <div class="info rub-info" id="RUB">
                        <@cond.depositRUB type="${deposit.type}" termMin="${deposit.termMin}" termMax="${deposit.termMax}" />
                    </div>
                    <div class="info eur-info" id="EUR">
                        <@cond.depositEUR type="${deposit.type}" termMin="${deposit.termMin}" termMax="${deposit.termMax}" />
                    </div>
                    <div class="info usd-info" id="USD">
                        <@cond.depositUSD type="${deposit.type}" termMin="${deposit.termMin}" termMax="${deposit.termMax}" />
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Сумма:</label>
            <div class="col-sm-4">
                <div class="row">
                    <div class="col">
                        <input type="number" name="amount"
                               min="<#if deposit??>${deposit.amountMin}</#if>"
                               placeholder="${deposit.amountMin}"
                               class="form-control ${(amountError??)?string('is-invalid', '')}"
                               required aria-describedby="amountHelp" />
                        <small id="amountHelp" class="form-text text-muted">Минимальная сумма вклада ${deposit.amountMin} <#list deposit.currency as c>${c}<#sep> | </#list></small>
                        <#if amountError??>
                            <div class="invalid-feedback">
                                ${amountError}
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" name="depositId" value="${deposit.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit" form="my">Подать заявку</button>
    </form>
</@c.page>