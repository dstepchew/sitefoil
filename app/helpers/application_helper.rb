 module ApplicationHelper


  def self.timezones

    zones = {}
    ActiveSupport::TimeZone.zones_map.values.collect do  |z| 
      if !zones[z.utc_offset]
        zones[z.utc_offset] = [z.name]
      else
        if zones[z.utc_offset].count<8
          zones[z.utc_offset] << z.name
        end
      end
    end

    ret = zones.collect do |offset,cities|

      cities = cities.sort.join(", ")
      [format(" GMT %+03d:%02d", offset/3600, offset/60%60)+" #{cities}",offset/60]

    end

    ret.sort! do |a,b|
      a[1] <=> b[1]
    end
    
    ret
  end

	def self.trigger_channels
		['referrer']
	end

	def self.action_channels
		['input element']
	end


  def self.trigger_by_name name
    self.triggers.each { |trigger|
      return trigger if trigger[:name] == name
    }
    nil
  end

	def self.triggers
		[
      { name: 'all-time conversion rate percent', help: 'This refers to the percentage of all-time site visits that resulted in a transaction.  Do not include the percentage symbol (only the number).', js: 'site.conversion_rate', methods: ['==?','>=?','<=?'], input_type: :number},
      { name: 'conversion rate percent (last 24 hours)', help: 'This refers to the percentage of site visits that resulted in a transaction in the last 24 hours.  Do not include the percentage symbol (only the number).', js: 'site.conversion_rate_24_hours', methods: ['==?','>=?','<=?'], input_type: :number},
      { name: 'all-time transactions (order count)', help: 'This refers to the number of site transactions recorded on your site all-time. This does not inlude any transactions that occured before SiteFoil began tracking your site activity.', js: 'site.order_count', methods: ['==?','>=?','<=?'], 
        input_type: :number},
      { name: 'visitor ip address', help: 'This refers to the ip address of each site visitor.', js: 'visitor.ip', methods: ['=="?"','!="?"'] },
      { name: 'visitor language', help: 'This refers to the default browser language used by each site visitor.', js: 'sitefoil.language.toLowerCase()', methods: ['=="?"','!="?"'], possible_values:{'af'=>'Afrikaans','ar-ae'=>'Arabic (U.A.E.)','ar-bh'=>'Arabic (Bahrain)','ar-dz'=>'Arabic (Algeria)','ar-eg'=>'Arabic (Egypt)','ar-iq'=>'Arabic (Iraq)','ar-jo'=>'Arabic (Jordan)','ar-kw'=>'Arabic (Kuwait)','ar-lb'=>'Arabic (Lebanon)','ar-ly'=>'Arabic (Libya)','ar-ma'=>'Arabic (Morocco)','ar-om'=>'Arabic (Oman)','ar-qa'=>'Arabic (Qatar)','ar-sa'=>'Arabic (Saudi Arabia)','ar-sy'=>'Arabic (Syria)','ar-tn'=>'Arabic (Tunisia)','ar-ye'=>'Arabic (Yemen)','be'=>'Belarusian','bg'=>'Bulgarian','ca'=>'Catalan','cs'=>'Czech','da'=>'Danish','de'=>'German (Standard)','de-at'=>'German (Austria)','de-ch'=>'German (Switzerland)','de-li'=>'German (Liechtenstein)','de-lu'=>'German (Luxembourg)','el'=>'Greek','en'=>'English','en'=>'English (Caribbean)','en-au'=>'English (Australia)','en-bz'=>'English (Belize)','en-ca'=>'English (Canada)','en-gb'=>'English (United Kingdom)','en-ie'=>'English (Ireland)','en-jm'=>'English (Jamaica)','en-nz'=>'English (New Zealand)','en-tt'=>'English (Trinidad)','en-us'=>'English (United States)','en-za'=>'English (South Africa)','es'=>'Spanish (Spain)','es-ar'=>'Spanish (Argentina)','es-bo'=>'Spanish (Bolivia)','es-cl'=>'Spanish (Chile)','es-co'=>'Spanish (Colombia)','es-cr'=>'Spanish (Costa Rica)','es-do'=>'Spanish (Dominican Republic)','es-ec'=>'Spanish (Ecuador)','es-gt'=>'Spanish (Guatemala)','es-hn'=>'Spanish (Honduras)','es-mx'=>'Spanish (Mexico)','es-ni'=>'Spanish (Nicaragua)','es-pa'=>'Spanish (Panama)','es-pe'=>'Spanish (Peru)','es-pr'=>'Spanish (Puerto Rico)','es-py'=>'Spanish (Paraguay)','es-sv'=>'Spanish (El Salvador)','es-uy'=>'Spanish (Uruguay)','es-ve'=>'Spanish (Venezuela)','et'=>'Estonian','eu'=>'Basque (Basque)','fa'=>'Farsi','fi'=>'Finnish','fo'=>'Faeroese','fr'=>'French (Standard)','fr-be'=>'French (Belgium)','fr-ca'=>'French (Canada)','fr-ch'=>'French (Switzerland)','fr-lu'=>'French (Luxembourg)','ga'=>'Irish','gd'=>'Gaelic (Scotland)','he'=>'Hebrew','hi'=>'Hindi','hr'=>'Croatian','hu'=>'Hungarian','id'=>'Indonesian','is'=>'Icelandic','it'=>'Italian (Standard)','it-ch'=>'Italian (Switzerland)','ja'=>'Japanese','ji'=>'Yiddish','ko'=>'Korean','ko'=>'Korean (Johab)','lt'=>'Lithuanian','lv'=>'Latvian','mk'=>'Macedonian (FYROM)','ms'=>'Malaysian','mt'=>'Maltese','nl'=>'Dutch (Standard)','nl-be'=>'Dutch (Belgium)','no'=>'Norwegian (Bokmal)','no'=>'Norwegian (Nynorsk)','pl'=>'Polish','pt'=>'Portuguese (Portugal)','pt-br'=>'Portuguese (Brazil)','rm'=>'Rhaeto-Romanic','ro'=>'Romanian','ro-mo'=>'Romanian (Republic of Moldova)','ru'=>'Russian','ru-mo'=>'Russian (Republic of Moldova)','sb'=>'Sorbian','sk'=>'Slovak','sl'=>'Slovenian','sq'=>'Albanian','sr'=>'Serbian (Cyrillic)','sr'=>'Serbian (Latin)','sv'=>'Swedish','sv-fi'=>'Swedish (Finland)','sx'=>'Sutu','sz'=>'Sami (Lappish)','th'=>'Thai','tn'=>'Tswana','tr'=>'Turkish','ts'=>'Tsonga','uk'=>'Ukrainian','ur'=>'Urdu','ve'=>'Venda','vi'=>'Vietnamese','xh'=>'Xhosa','zh-cn'=>'Chinese (PRC)','zh-hk'=>'Chinese (Hong Kong SAR)','zh-sg'=>'Chinese (Singapore)','zh-tw'=>'Chinese (Taiwan)','zu'=>'Zulu'} },
      { name: 'current time', help: 'This refers to the current time in hours and minutes based on your site time zone.', js: 'sitefoil.hours_minutes_int', 
        input_type: :time,
        methods: ['==sitefoil.hours_minutes_to_int("?")','>=sitefoil.hours_minutes_to_int("?")','<=sitefoil.hours_minutes_to_int("?")','!=sitefoil.hours_minutes_to_int("?")'] },
      { name: 'current date', help: 'This refers to the current date based on your site time zone.', js: 'sitefoil.date_int', 
        input_type: :date,
        methods: ['==sitefoil.date_to_int("?")','>=sitefoil.date_to_int("?")','<=sitefoil.date_to_int("?")','!=sitefoil.date_to_int("?")'] },
      { name: 'any page visit', help: 'Unless you add more triggers to this recipe, this alone will trigger your action anytime anyone visits the site.', js: '', methods: ['true'] },
      { name: 'page url', help: 'Refers to the page each visitor is browsing on your site. Use full page URLs for exact match or use wildcards (*) for broad matches, i.e. "*www.sitefoil.com/sites/*"', js: 'true', methods: ['==sitefoil.page_url_match("?")', '!=sitefoil.page_url_match("?")'] },
      { name: 'element clicked id', help: 'This refers to any visitor click behavior on any matching/non-matching ID found in the HTML of your site.', js: 'el_clicked_selector', methods: ['=="?"'],
        input_type: :selector_pick },
			{ name: 'referrer', help: 'This refers to the web address from where a site visitor was referred to your website. Wildcards (*) may be used for broad matches.', js: 'document.referrer', methods: ['=="?"','!="?"']},
	    { name: 'country', help: 'This refers to the country associated with the ip addresses assigned to your site visitors.', js: 'visitor.country', methods: ['=="?"','!="?"'], possible_values:{'Afghanistan'=>'Afghanistan','Albania'=>'Albania','Algeria'=>'Algeria','Andorra'=>'Andorra','Angola'=>'Angola','Antigua & Deps'=>'Antigua & Deps','Argentina'=>'Argentina','Armenia'=>'Armenia','Australia'=>'Australia','Austria'=>'Austria','Azerbaijan'=>'Azerbaijan','Bahamas'=>'Bahamas','Bahrain'=>'Bahrain','Bangladesh'=>'Bangladesh','Barbados'=>'Barbados','Belarus'=>'Belarus','Belgium'=>'Belgium','Belize'=>'Belize','Benin'=>'Benin','Bhutan'=>'Bhutan','Bolivia'=>'Bolivia','Bosnia Herzegovina'=>'Bosnia Herzegovina','Botswana'=>'Botswana','Brazil'=>'Brazil','Brunei'=>'Brunei','Bulgaria'=>'Bulgaria','Burkina'=>'Burkina','Burundi'=>'Burundi','Cambodia'=>'Cambodia','Cameroon'=>'Cameroon','Canada'=>'Canada','Cape Verde'=>'Cape Verde','Central African Rep'=>'Central African Rep','Chad'=>'Chad','Chile'=>'Chile','China'=>'China','Colombia'=>'Colombia','Comoros'=>'Comoros','Congo'=>'Congo','Congo {Democratic Rep}'=>'Congo (DRC)','Costa Rica'=>'Costa Rica','Croatia'=>'Croatia','Cuba'=>'Cuba','Cyprus'=>'Cyprus','Czech Republic'=>'Czech Republic','Denmark'=>'Denmark','Djibouti'=>'Djibouti','Dominica'=>'Dominica','Dominican Republic'=>'Dominican Republic','East Timor'=>'East Timor','Ecuador'=>'Ecuador','Egypt'=>'Egypt','El Salvador'=>'El Salvador','Equatorial Guinea'=>'Equatorial Guinea','Eritrea'=>'Eritrea','Estonia'=>'Estonia','Ethiopia'=>'Ethiopia','Fiji'=>'Fiji','Finland'=>'Finland','France'=>'France','Gabon'=>'Gabon','Gambia'=>'Gambia','Georgia'=>'Georgia','Germany'=>'Germany','Ghana'=>'Ghana','Greece'=>'Greece','Grenada'=>'Grenada','Guatemala'=>'Guatemala','Guinea'=>'Guinea','Guinea-Bissau'=>'Guinea-Bissau','Guyana'=>'Guyana','Haiti'=>'Haiti','Honduras'=>'Honduras','Hungary'=>'Hungary','Iceland'=>'Iceland','India'=>'India','Indonesia'=>'Indonesia','Iran'=>'Iran','Iraq'=>'Iraq','Ireland'=>'Ireland','Israel'=>'Israel','Italy'=>'Italy','Ivory Coast'=>'Ivory Coast','Jamaica'=>'Jamaica','Japan'=>'Japan','Jordan'=>'Jordan','Kazakhstan'=>'Kazakhstan','Kenya'=>'Kenya','Kiribati'=>'Kiribati','North Korea'=>'North Korea','South Korea'=>'South Korea','Kosovo'=>'Kosovo','Kuwait'=>'Kuwait','Kyrgyzstan'=>'Kyrgyzstan','Laos'=>'Laos','Latvia'=>'Latvia','Lebanon'=>'Lebanon','Lesotho'=>'Lesotho','Liberia'=>'Liberia','Libya'=>'Libya','Liechtenstein'=>'Liechtenstein','Lithuania'=>'Lithuania','Luxembourg'=>'Luxembourg','Macedonia'=>'Macedonia','Madagascar'=>'Madagascar','Malawi'=>'Malawi','Malaysia'=>'Malaysia','Maldives'=>'Maldives','Mali'=>'Mali','Malta'=>'Malta','Marshall Islands'=>'Marshall Islands','Mauritania'=>'Mauritania','Mauritius'=>'Mauritius','Mexico'=>'Mexico','Micronesia'=>'Micronesia','Moldova'=>'Moldova','Monaco'=>'Monaco','Mongolia'=>'Mongolia','Montenegro'=>'Montenegro','Morocco'=>'Morocco','Mozambique'=>'Mozambique','Myanmar, {Burma}'=>'Myanmar, {Burma}','Namibia'=>'Namibia','Nauru'=>'Nauru','Nepal'=>'Nepal','Netherlands'=>'Netherlands','New Zealand'=>'New Zealand','Nicaragua'=>'Nicaragua','Niger'=>'Niger','Nigeria'=>'Nigeria','Norway'=>'Norway','Oman'=>'Oman','Pakistan'=>'Pakistan','Palau'=>'Palau','Panama'=>'Panama','Papua New Guinea'=>'Papua New Guinea','Paraguay'=>'Paraguay','Peru'=>'Peru','Philippines'=>'Philippines','Poland'=>'Poland','Portugal'=>'Portugal','Qatar'=>'Qatar','Romania'=>'Romania','Russian Federation'=>'Russian Federation','Rwanda'=>'Rwanda','St Kitts & Nevis'=>'St Kitts & Nevis','St Lucia'=>'St Lucia','Saint Vincent & the Grenadines'=>'Saint Vincent & the Grenadines','Samoa'=>'Samoa','San Marino'=>'San Marino','Sao Tome & Principe'=>'Sao Tome & Principe','Saudi Arabia'=>'Saudi Arabia','Senegal'=>'Senegal','Serbia'=>'Serbia','Seychelles'=>'Seychelles','Sierra Leone'=>'Sierra Leone','Singapore'=>'Singapore','Slovakia'=>'Slovakia','Slovenia'=>'Slovenia','Solomon Islands'=>'Solomon Islands','Somalia'=>'Somalia','South Africa'=>'South Africa','South Sudan'=>'South Sudan','Spain'=>'Spain','Sri Lanka'=>'Sri Lanka','Sudan'=>'Sudan','Suriname'=>'Suriname','Swaziland'=>'Swaziland','Sweden'=>'Sweden','Switzerland'=>'Switzerland','Syria'=>'Syria','Taiwan'=>'Taiwan','Tajikistan'=>'Tajikistan','Tanzania'=>'Tanzania','Thailand'=>'Thailand','Togo'=>'Togo','Tonga'=>'Tonga','Trinidad & Tobago'=>'Trinidad & Tobago','Tunisia'=>'Tunisia','Turkey'=>'Turkey','Turkmenistan'=>'Turkmenistan','Tuvalu'=>'Tuvalu','Uganda'=>'Uganda','Ukraine'=>'Ukraine','United Arab Emirates'=>'United Arab Emirates','United Kingdom'=>'United Kingdom','United States'=>'United States','Uruguay'=>'Uruguay','Uzbekistan'=>'Uzbekistan','Vanuatu'=>'Vanuatu','Vatican City'=>'Vatican City','Venezuela'=>'Venezuela','Vietnam'=>'Vietnam','Yemen'=>'Yemen','Zambia'=>'Zambia','Zimbabwe'=>'Zimbabwe'} },
	    { name: 'hour', help: 'This refers to the current hour in a 24 hour cycle based on your site time zone.', js: 'visitor.hour', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'weekday number', help: 'This refers to the current weekday in a 7 day cycle based on your site time zone, starting on Sunday.', js: 'vistor.weekday', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'visitor type', help: 'This refers to the visit history of each visitor. Returning visitors have visited the site in the last 30 days.', js: 'sitefoil.visitor_type()', methods: ['=="new"','=="returning"']},
	    { name: 'device', help: 'This refers to the device platform used by each visitor to your site.', js: 'visitor.device', methods: ['=="?"','!="?"'], possible_values: ['desktop','tablet','phone']},
      { name: 'operating system', help: 'This refers to the operating system used by each site visitor.', js: 'visitor.os_name', methods: ['=="?"','!="?"'], possible_values: ['unknown','Windows','MacOS','Android','Linux','UNIX'] }
	  ]
	end

  def self.action_by_name name
    self.actions.each { |action| 
      return action if action[:name]==name
    }
    nil
  end
	def self.actions
    [
      { name: 'custom site footer', help: 'This action allows you to overlay your site footer with your custom HTML inside the following standard output:
<div class=sitefoil-footer style=z-index:99999; position:fixed; bottom:0px; width:100%; margin:0px; padding:0px; > YOUR HTML GOES HERE </div>', js: 'sitefoil.footer_show(":html")', params: [{name: :html, input_type: :textarea }] },
      { name: 'welcome banner', help: 'This action allows you to overlay your site banner with your custom HTML inside the following standard output:
<div class=sitefoil-banner style=z-index:99999; position:fixed; top:0px; width:100%; margin:0px; padding:0px;> Your HTML goes here </div>', js: 'sitefoil.banner_show(":html")', params: [{name: :html, input_type: :textarea }] },
      { name: 'welcome popup', help:'This action will overlay your site with a jquery popup with your custom HTML inside the following standard output:
<div id=sitefoil_popup_overlay style="z-index:10000; position:fixed; top:0px; left:0px; width:100%; height:100%; background:#000; opacity:0"></div><div id=sitefoil_popup style="opacity:0; display:none; padding:20px; box-shadow:rgba(0, 0, 0, 0.4) 0px 0px 10px 0px; background:#fff; top:0px;animation-top:2s; position:fixed; z-index:10001;"> Your HTML goes here <center> <input style="margin-top:20px; border:#eee; border-radius:5px; padding:10px; cursor:pointer;" type=button id=sitefoil_popup_ok onclick=sitefoil.popup_close() value="OK"> </center> </div>', js: 'sitefoil.popup_show({html: ":html", once_per_session: :once_per_session, recipe_id: recipe_id})', params: [{name: :html, input_type: :textarea },{name: :once_per_session, caption: "show only once per session", input_type: :checkbox}] },
      { name: 'show hidden element', help:'This action will override the display property of any matching element so that it is display:block', js: 'sitefoil.$(":selector").show()', params: [:selector]},
    	{ name: 'alert', help:'This action will prompt a basic browser javascript alert with your text.', js: 'alert(":message")', params: [:message] },
    	{ name: 'autofill', help:'This action will force your custom text into any field you choose based on a designated input ID', js: 'document.querySelector(":selector").value=":value"', params:[{name: :selector, input_type: :selector_pick},:value] },
      { name: 'autofill and submit', help:'This action will force custom text into any field you choose based on a designated input ID and then it will submit the form the field belongs to - used in cases were you want to auto-apply a discount code.', js: 'sitefoil.autofill_and_submit(":selector",":value")', params:[{name: :selector, input_type: :selector_pick},:value]},
    	{ name: 'send email', help:'This action will send a basic email to any email address.', js: 'this.email_to(":to_email",":message")', params: [{name: :to_email},{name: :message,input_type: :textarea}] },
      { name: 'console log', help:'This action will add messages into your browsers console log (for testing).', js: 'console.log(":message")', params: [:message]},
      { name: 'run javascript', help:'This action will run any custom javascript. Run this in combination with other html recipes that require javascript', js: 'eval.apply(window,[":javascript"])', params: [{name: :javascript, input_type: :textarea}] }
    ]
  end

  def self.human_method js
  	ret = {
  	 '.one_of("?")'=>"one of",
     'true'=>'happens',
  	 '!="?"'=>'does not equal',
  	 '!=?'=>'does not equal',
  	 '==?'=>'equals', 
  	 '=="?"'=>'equals',
  	 '>=?'=>'greater or equal to', 
  	 '<=?'=>'lower or equal to'}[js]
  	return ret if ret

  	if js.starts_with? '=="'
  		return "is "+js.gsub('=="','').gsub('"','')
  	end

    ret = {
      '==' => 'equals',
      '>=' => 'is equal to or after',
      '<=' => 'is equal to or before',
      '!=' => 'is not'
    }[js[0,2]]

    return ret if ret

  end

end
