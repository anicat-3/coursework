<#include "security.ftlh">
<#import "login.ftlh" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="/">
            <img src="/img/logo/belveb-logo.svg.png" alt="BelVEB" width="60" height="35"/>
        </a>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/user">Пользователи</a>
                    </li>
                </#if>
                <#if isEmployee>
                    <li class="nav-item">
                        <a class="nav-link" href="/client">Клиенты</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/request">Заявки</a>
                    </li>
                </#if>
                <#if user?? && !isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/deposit">Вклады</a>
                    </li>
                </#if>
                <#if user?? && !isAdmin && !isEmployee>
                    <li class="nav-item">
                        <form action="/request/${id}" method="get">
                            <input type="hidden" name="userId" value="${id}">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-link nav-link">Мои заявки</button>
                        </form>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/profile">Мой профиль</a>
                    </li>
                </#if>
                <#if isEmployee>
                    <li class="nav-item">
                        <a class="nav-link" href="/closeBankDay">Закрыть банковский день</a>
                    </li>
                </#if>
            </ul>

            <#if name == "unknown">
                <div class="navbar-text mr-3">
                    ${name}
                </div>
            <#else>
                <a class="nav-link mr-5" href="/user/account">${name}</a>
            </#if>

            <#if user??>
                <@l.logout />
            <#else>
                <a class="nav-link mr-5" href="/login">Войти</a>
            </#if>
        </div>
    </div>
</nav>