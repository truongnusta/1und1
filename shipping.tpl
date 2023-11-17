{*
* 2007-2022 ETS-Soft
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses.
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs, please contact us for extra customization service at an affordable price
*
*  @author ETS-Soft <etssoft.jsc@gmail.com>
*  @copyright  2007-2022 ETS-Soft
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of ETS-Soft
*}
{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  <div id="hook-display-before-carrier">
    {$hookDisplayBeforeCarrier nofilter}
  </div>

  <div class="delivery-options-list">
    {if $delivery_options|count}
      <form
        class="clearfix"
        id="js-delivery"
        data-url-update="{url entity='order' params=['ajax' => 1, 'action' => 'selectDeliveryOption']}"
        method="post"
      >
        <div class="form-fields">
          {block name='delivery_options'}
            <div class="delivery-options">
              {foreach from=$delivery_options item=carrier key=carrier_id}
                  <div class="delivery-option">
                    <div class="col-sm-1">
                      <span class="custom-radio pull-xs-left">
                        <input type="radio" name="delivery_option[{$id_address|escape:'html':'UTF-8'}]" id="delivery_option_{$carrier.id|escape:'html':'UTF-8'}" value="{$carrier_id|escape:'html':'UTF-8'}"{if $delivery_option == $carrier_id} checked{/if}>
                        <span></span>
                      </span>
                    </div>
                    <label for="delivery_option_{$carrier.id|escape:'html':'UTF-8'}" class="col-sm-11 delivery-option-2">
                      <div class="row">
                        <div class="col-sm-5 col-xs-12">
                          <div class="row">
                            {if $carrier.logo}
                            <div class="col-xs-3">
                                <img src="{$carrier.logo|escape:'html':'UTF-8'}" alt="{$carrier.name|escape:'html':'UTF-8'}" />
                            </div>
                            {/if}
                            <div class="{if $carrier.logo}col-xs-9{else}col-xs-12{/if}">
                              <span class="h6 carrier-name">{$carrier.name|escape:'html':'UTF-8'}</span>
                            </div>
                          </div>
                        </div>
                        <div class="col-sm-4 col-xs-12">
                          <span class="carrier-delay">{$carrier.delay|escape:'html':'UTF-8'}</span>
                        </div>
                        <div class="col-sm-3 col-xs-12">
                          <span class="carrier-price">{$carrier.price|escape:'html':'UTF-8'}</span>
                        </div>
                      </div>
                    </label>
                    <div class="col-md-12 carrier-extra-content"{if $delivery_option != $carrier_id} style="display:none;"{/if}>
                        {$carrier.extraContent nofilter}
                    </div>
                    <div class="clearfix"></div>
                  </div>
              {/foreach}
            </div>
          {/block}
          <div class="order-options">
            {if $recyclablePackAllowed}
              <label>
                <input type="checkbox" name="recyclable" value="1" {if $recyclable} checked {/if}>
                <span>{l s='I would like to receive my order in recycled packaging.' d='Shop.Theme.Checkout'}</span>
              </label>
            {/if}
            {if $gift.allowed}
              <span class="custom-checkbox">
                <input
                  class="js-gift-checkbox"
                  name="gift"
                  type="checkbox"
                  value="1"
                  {if $gift.isGift}checked="checked"{/if}
                >
                <span><i class="material-icons checkbox-checked">&#xE5CA;</i></span>
                <label>{$gift.label|escape:'html':'UTF-8'}</label >
              </span>

              <div id="gift" class="collapse{if $gift.isGift} in{/if}">
                <label for="gift_message">{l s='If you\'d like, you can add a note to the gift:' d='Shop.Theme.Checkout'}</label>
                <textarea rows="2" cols="120" id="gift_message" name="gift_message">{$gift.message|escape:'html':'UTF-8'}</textarea>
              </div>

            {/if}
          </div>
        </div>
        <button type="submit" class="continue btn btn-primary pull-xs-right" name="confirmDeliveryOption" value="1">
          {l s='Continue' d='Shop.Theme.Actions'}
        </button>
      </form>
    {else}
      <p class="alert alert-danger">{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>

  <div id="hook-display-after-carrier">
    {$hookDisplayAfterCarrier nofilter}
  </div>

  <div id="extra_carrier"></div>
{/block}
