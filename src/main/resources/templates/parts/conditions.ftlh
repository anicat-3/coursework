<#import "terms.ftlh" as r>
<#macro depositBYN type termMin termMax>
    <#if type == "DEMAND">
        <input type="hidden" name="term" value="100"/>
        <label class="col-sm-4 col-form-label">До востребования под 3% годовых</label>
    </#if>
    <#if type == "TIME_REVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="3" rate="3.5" />
            <@r.radio min=termMin max=termMax term="6" rate="4.1" />
            <@r.radio min=termMin max=termMax term="12" rate="4.1" />
            <@r.radio min=termMin max=termMax term="18" rate="4.1" />
            <@r.radio min=termMin max=termMax term="24" rate="4.1" />
        </fieldset>
    </#if>
    <#if type == "TIME_IRREVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="3" rate="7" />
            <@r.radio min=termMin max=termMax term="7" rate="8.2" />
            <@r.radio min=termMin max=termMax term="13" rate="13.2" />
            <@r.radio min=termMin max=termMax term="24" rate="12.9" />
        </fieldset>
    </#if>
</#macro>

<#macro depositRUB type termMin termMax>
    <#if type == "DEMAND">
        <input type="hidden" name="term" value="100"/>
        <label class="col-sm-4 col-form-label">До востребования под 0.1% годовых</label>
    </#if>
    <#if type == "TIME_REVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="12" rate="3.7" />
            <@r.radio min=termMin max=termMax term="24" rate="5" />
        </fieldset>
    </#if>
    <#if type == "TIME_IRREVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="3" rate="5.3" />
            <@r.radio min=termMin max=termMax term="7" rate="6.6" />
            <@r.radio min=termMin max=termMax term="13" rate="7.2" />
            <@r.radio min=termMin max=termMax term="24" rate="8.4" />
        </fieldset>
    </#if>
</#macro>

<#macro depositEUR type termMin termMax>
    <#if type == "DEMAND">
        <input type="hidden" name="term" value="100"/>
        <label class="col-sm-4 col-form-label">До востребования под 0.001% годовых</label>
    </#if>
    <#if type == "TIME_REVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="12" rate="0.1" />
            <@r.radio min=termMin max=termMax term="24" rate="0.1" />
        </fieldset>
    </#if>
    <#if type == "TIME_IRREVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="3" rate="0.1" />
            <@r.radio min=termMin max=termMax term="7" rate="0.6" />
            <@r.radio min=termMin max=termMax term="13" rate="0.9" />
            <@r.radio min=termMin max=termMax term="24" rate="1.5" />
        </fieldset>
    </#if>
</#macro>

<#macro depositUSD type termMin termMax>
    <#if type == "DEMAND">
        <input type="hidden" name="term" value="100"/>
        <label class="col-sm-4 col-form-label">До востребования под 0.04% годовых</label>
    </#if>
    <#if type == "TIME_REVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="12" rate="0.1" />
            <@r.radio min=termMin max=termMax term="24" rate="0.1" />
        </fieldset>
    </#if>
    <#if type == "TIME_IRREVOCABLE">
        <fieldset>
            <@r.radio min=termMin max=termMax term="3" rate="0.1" />
            <@r.radio min=termMin max=termMax term="7" rate="0.2" />
            <@r.radio min=termMin max=termMax term="13" rate="0.9" />
            <@r.radio min=termMin max=termMax term="24" rate="1.7" />
        </fieldset>
    </#if>
</#macro>