<#macro radio min max term rate>
    <#if min?number lte term?number && max?number gte term?number>
        <div class="form-check">
            <input type="radio" name="term" value="${term}" class="form-check-input" required/>
            <label class="form-check-label">${term} мес. под ${rate}% годовых</label>
            <input type="hidden" name="rate" value="${rate}" />
        </div>
    </#if>
</#macro>