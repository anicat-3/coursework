<#macro depositForm path isEditForm>
    <form action="${path}" method="post">

        <h5><#if isEditForm>Редактировать данные о вкладе<#else>Создание нового вклада</#if></h5>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Название вклада:</label>
            <div class="col-sm-4">
                <input type="text" name="name" value="<#if deposit??>${deposit.name}</#if>"
                       class="form-control ${(nameError??)?string('is-invalid', '')}"
                       placeholder="Название"/>
                <#if nameError??>
                    <div class="invalid-feedback">
                        ${nameError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Процентная ставка:</label>
            <div class="col-sm-4">
                <input type="text" name="interestRate" value="<#if deposit??>${deposit.interestRate?replace(",", ".")}</#if>"
                       class="form-control ${(interestRateError??)?string('is-invalid', '')}"
                       placeholder="0.00" />
                <#if interestRateError??>
                    <div class="invalid-feedback">
                        ${interestRateError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Тип вклада:</label>
            <div class="col-sm-4">
                <fieldset>
                    <div class="form-check">
                        <input type="radio" name="type" value="DEMAND" class="form-check-input"
                                <#if deposit??>${deposit.type?contains("DEMAND")?string("checked","")}</#if> required/>
                        <label class="form-check-label">До востребования</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="type" value="TIME_REVOCABLE" class="form-check-input"
                                <#if deposit??>${deposit.type?contains("TIME_REVOCABLE")?string("checked","")}</#if>/>
                        <label class="form-check-label">Срочный (отзывной)</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="type" value="TIME_IRREVOCABLE" class="form-check-input"
                                <#if deposit??>${deposit.type?contains("TIME_IRREVOCABLE")?string("checked","")}</#if>/>
                        <label class="form-check-label">Срочный (безотзывной)</label>
                    </div>
                </fieldset>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Валюта вклада:</label>
            <div class="col-sm-4">
                <fieldset>
                    <#list currencies as currency>
                        <div class="checkbox-group required">
                            <input type="checkbox" name="currency"
                                   value="${currency}" <#if deposit?? && deposit.currency??>${deposit.currency?seq_contains(currency)?string("checked","")}</#if>/>
                            <label>${currency}</label>
                        </div>
                    </#list>
                </fieldset>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Ограничения по сумме:</label>
            <div class="col-sm-4">
                <div class="row">
                    <div class="col">
                        <input type="number" min="0" name="amountMin"
                               value="<#if deposit?? && deposit.amountMin??>${deposit.amountMin}</#if>"
                               class="form-control ${(amountMinError??)?string('is-invalid', '')}"
                               aria-describedby="amountMinHelp"/>
                        <small id="amountMinHelp" class="form-text text-muted">Минимальная сумма вклада</small>
                        <#if amountMinError??>
                            <div class="invalid-feedback">
                                ${amountMinError}
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Ограничения по сроку вклада:</label>
            <div class="col-sm-4">
                <div class="row">
                    <div class="col">
                        <input type="number" min="0" name="termMin"
                               value="<#if deposit?? && deposit.termMin??>${deposit.termMin}</#if>"
                               class="form-control ${(termMinError??)?string('is-invalid', '')}"
                               aria-describedby="termMinHelp"/>
                        <small id="termMinHelp" class="form-text text-muted">Минимальный срок вклада (в месяцах)</small>
                        <#if termMinError??>
                            <div class="invalid-feedback">
                                ${termMinError}
                            </div>
                        </#if>
                    </div>
                    <div class="col">
                        <input type="number" min="0" name="termMax"
                               value="<#if deposit?? && deposit.termMax??>${deposit.termMax}</#if>"
                               class="form-control ${(termMaxError??)?string('is-invalid', '')}"
                               aria-describedby="termMaxHelp"/>
                        <small id="termMaxHelp" class="form-text text-muted">Максимальный срок вклада (в
                            месяцах)</small>
                        <#if termMaxError??>
                            <div class="invalid-feedback">
                                ${termMaxError}
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>

        <#if isEditForm>
        <input type="hidden" name="depositId" value="${deposit.id}">
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit"><#if isEditForm>Сохранить<#else>Добавить</#if></button>
    </form>
</#macro>