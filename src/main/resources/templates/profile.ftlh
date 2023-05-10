<#setting date_format="yyyy/MM/dd">
<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<@c.page>
    <div class="container">
        <#if userDescription??>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Имя пользователя:</label>
                <label class="col-sm-4 col-form-label">${username}</label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Фамилия:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.surname??>
                        ${userDescription.surname}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Имя:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.name??>
                        ${userDescription.name}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Отчество:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.patronymic??>
                        ${userDescription.patronymic}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Дата рождения:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.dob??>
                        ${userDescription.dob?date?string('yyyy-MM-dd')}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Серия и номер паспорта:</label>
                <label class="col-sm-1 col-form-label">
                    <#if userDescription.passportSeries??>
                        ${userDescription.passportSeries}
                    </#if>
                </label>
                <label class="col-form-label">
                    <#if userDescription.passportNumber??>
                        ${userDescription.passportNumber}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Идентификационный номер:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.passportId??>
                        ${userDescription.passportId}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Кем выдан:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.passportIssuedBy??>
                        ${userDescription.passportIssuedBy}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Дата выдачи:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.passportIssuedDate??>
                        ${userDescription.passportIssuedDate?date?string('yyyy-MM-dd')}
                    </#if>
                </label>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Гражданство:</label>
                <label class="col-sm-4 col-form-label">
                    <#if userDescription.citizenship??>
                        ${userDescription.citizenship}
                    </#if>
                </label>
            </div>
        </#if>

        <#if isAdmin>
            <div class="col-2">
                <form action="profile/edit" method="get">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button class="btn btn-primary" type="submit">Редактировать</button>
                </form>
            </div>
        </#if>
        <#if isEmployee>
            <div class="col-2">
                <form action="/client" method="get">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button class="btn btn-outline-dark" type="submit">Назад</button>
                </form>
            </div>
        <#else>
            <div class="col-2">
                <form action="/user" method="get">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button class="btn btn-outline-dark" type="submit">Назад</button>
                </form>
            </div>
        </#if>
    </div>
</@c.page>