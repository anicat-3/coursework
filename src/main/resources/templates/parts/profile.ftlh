<#setting date_format="yyyy/MM/dd">
<#macro profile path>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Имя пользователя:</label>
            <label class="col-sm-4 col-form-label">${username}</label>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Фамилия:</label>
            <div class="col-sm-4">
                <input type="text" name="surname"
                       value="<#if userDescription.surname??>${userDescription.surname}</#if>"
                       class="form-control ${(surnameError??)?string('is-invalid', '')}"
                       placeholder="Иванов"/>
                <#if surnameError??>
                    <div class="invalid-feedback">
                        ${surnameError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Имя:</label>
            <div class="col-sm-4">
                <input type="text" name="name"
                       value="<#if userDescription.name??>${userDescription.name}</#if>"
                       class="form-control ${(nameError??)?string('is-invalid', '')}"
                       placeholder="Иван"/>
                <#if nameError??>
                    <div class="invalid-feedback">
                        ${nameError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Отчество:</label>
            <div class="col-sm-4">
                <input type="text" name="patronymic"
                       value="<#if userDescription.patronymic??>${userDescription.patronymic}</#if>"
                       class="form-control ${(patronymicError??)?string('is-invalid', '')}"
                       placeholder="Иванович"/>
                <#if patronymicError??>
                    <div class="invalid-feedback">
                        ${patronymicError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Дата рождения:</label>
            <div class="col-sm-4">
                <input type="date" name="dob"
                       value="<#if userDescription.dob??>${(userDescription.dob)?date?string('yyyy-MM-dd')}</#if>"
                       class="form-control ${(dobError??)?string('is-invalid', '')}"
                       pattern="yyyy-MM-dd"/>
                <#if dobError??>
                    <div class="invalid-feedback">
                        ${dobError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Серия и номер паспорта:</label>
            <div class="col-sm-2">
                <input type="text" name="passportSeries"
                       value="<#if userDescription.passportSeries??>${userDescription.passportSeries}</#if>"
                       class="form-control ${(passportSeriesError??)?string('is-invalid', '')}"
                       placeholder="BM"/>
                <#if passportSeriesError??>
                    <div class="invalid-feedback">
                        ${passportSeriesError}
                    </div>
                </#if>
                <input type="text" name="passportNumber"
                       value="<#if userDescription.passportNumber??>${userDescription.passportNumber}</#if>"
                       class="form-control ${(passportNumberError??)?string('is-invalid', '')}"
                       placeholder="1234567"/>
                <#if passportNumberError??>
                    <div class="invalid-feedback">
                        ${passportNumberError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Идентификационный номер:</label>
            <div class="col-sm-4">
                <input type="text" name="passportId"
                       value="<#if userDescription.passportId??>${userDescription.passportId}</#if>"
                       class="form-control ${(passportIdError??)?string('is-invalid', '')}"
                       placeholder="4131087B052PB4"/>
                <#if passportIdError??>
                    <div class="invalid-feedback">
                        ${passportIdError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Кем выдан:</label>
            <div class="col-sm-4">
                <input type="text" name="passportIssuedBy"
                       value="<#if userDescription.passportIssuedBy??>${userDescription.passportIssuedBy}</#if>"
                       class="form-control ${(passportIssuedByError??)?string('is-invalid', '')}"
                       placeholder="Советское РОВД г. Минска"/>
                <#if passportIssuedByError??>
                    <div class="invalid-feedback">
                        ${passportIssuedByError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Дата выдачи:</label>
            <div class="col-sm-4">
                <input type="date" name="passportIssuedDate"
                       value="<#if userDescription.passportIssuedDate??>${userDescription.passportIssuedDate?date?string('yyyy-MM-dd')}</#if>"
                       class="form-control ${(passportIssuedDateError??)?string('is-invalid', '')}"
                       pattern="yyyy-MM-dd"/>
                <#if passportIssuedDateError??>
                    <div class="invalid-feedback">
                        ${passportIssuedDateError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Гражданство:</label>
            <div class="col-sm-4">
                <input type="text" name="citizenship"
                       value="<#if userDescription.citizenship??>${userDescription.citizenship}</#if>"
                       class="form-control ${(citizenshipError??)?string('is-invalid', '')}"
                       placeholder="РБ"/>
                <#if citizenshipError??>
                    <div class="invalid-feedback">
                        ${citizenshipError}
                    </div>
                </#if>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">Сохранить</button>
    </form>
</#macro>