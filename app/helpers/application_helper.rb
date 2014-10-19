module ApplicationHelper

	def self.trigger_channels
		['referrer']
	end

	def self.action_channels
		['input element']
	end


	def self.triggers
		[
      { name: 'transactions (order count)', js: 'any_event && site.order_count', methods: ['==?','>=?','<=?'], 
        input_type: 'number'},
      { name: 'ip address', js: 'any_event && visitor.ip', methods: ['=="?"','!="?"'] },
      { name: 'language', js: 'any_event && sitefoil.language.toLowerCase()', methods: ['=="?"','!="?"'], possible_values:{'af'=>'Afrikaans','ar-ae'=>'Arabic (U.A.E.)','ar-bh'=>'Arabic (Bahrain)','ar-dz'=>'Arabic (Algeria)','ar-eg'=>'Arabic (Egypt)','ar-iq'=>'Arabic (Iraq)','ar-jo'=>'Arabic (Jordan)','ar-kw'=>'Arabic (Kuwait)','ar-lb'=>'Arabic (Lebanon)','ar-ly'=>'Arabic (Libya)','ar-ma'=>'Arabic (Morocco)','ar-om'=>'Arabic (Oman)','ar-qa'=>'Arabic (Qatar)','ar-sa'=>'Arabic (Saudi Arabia)','ar-sy'=>'Arabic (Syria)','ar-tn'=>'Arabic (Tunisia)','ar-ye'=>'Arabic (Yemen)','be'=>'Belarusian','bg'=>'Bulgarian','ca'=>'Catalan','cs'=>'Czech','da'=>'Danish','de'=>'German (Standard)','de-at'=>'German (Austria)','de-ch'=>'German (Switzerland)','de-li'=>'German (Liechtenstein)','de-lu'=>'German (Luxembourg)','el'=>'Greek','en'=>'English','en'=>'English (Caribbean)','en-au'=>'English (Australia)','en-bz'=>'English (Belize)','en-ca'=>'English (Canada)','en-gb'=>'English (United Kingdom)','en-ie'=>'English (Ireland)','en-jm'=>'English (Jamaica)','en-nz'=>'English (New Zealand)','en-tt'=>'English (Trinidad)','en-us'=>'English (United States)','en-za'=>'English (South Africa)','es'=>'Spanish (Spain)','es-ar'=>'Spanish (Argentina)','es-bo'=>'Spanish (Bolivia)','es-cl'=>'Spanish (Chile)','es-co'=>'Spanish (Colombia)','es-cr'=>'Spanish (Costa Rica)','es-do'=>'Spanish (Dominican Republic)','es-ec'=>'Spanish (Ecuador)','es-gt'=>'Spanish (Guatemala)','es-hn'=>'Spanish (Honduras)','es-mx'=>'Spanish (Mexico)','es-ni'=>'Spanish (Nicaragua)','es-pa'=>'Spanish (Panama)','es-pe'=>'Spanish (Peru)','es-pr'=>'Spanish (Puerto Rico)','es-py'=>'Spanish (Paraguay)','es-sv'=>'Spanish (El Salvador)','es-uy'=>'Spanish (Uruguay)','es-ve'=>'Spanish (Venezuela)','et'=>'Estonian','eu'=>'Basque (Basque)','fa'=>'Farsi','fi'=>'Finnish','fo'=>'Faeroese','fr'=>'French (Standard)','fr-be'=>'French (Belgium)','fr-ca'=>'French (Canada)','fr-ch'=>'French (Switzerland)','fr-lu'=>'French (Luxembourg)','ga'=>'Irish','gd'=>'Gaelic (Scotland)','he'=>'Hebrew','hi'=>'Hindi','hr'=>'Croatian','hu'=>'Hungarian','id'=>'Indonesian','is'=>'Icelandic','it'=>'Italian (Standard)','it-ch'=>'Italian (Switzerland)','ja'=>'Japanese','ji'=>'Yiddish','ko'=>'Korean','ko'=>'Korean (Johab)','lt'=>'Lithuanian','lv'=>'Latvian','mk'=>'Macedonian (FYROM)','ms'=>'Malaysian','mt'=>'Maltese','nl'=>'Dutch (Standard)','nl-be'=>'Dutch (Belgium)','no'=>'Norwegian (Bokmal)','no'=>'Norwegian (Nynorsk)','pl'=>'Polish','pt'=>'Portuguese (Portugal)','pt-br'=>'Portuguese (Brazil)','rm'=>'Rhaeto-Romanic','ro'=>'Romanian','ro-mo'=>'Romanian (Republic of Moldova)','ru'=>'Russian','ru-mo'=>'Russian (Republic of Moldova)','sb'=>'Sorbian','sk'=>'Slovak','sl'=>'Slovenian','sq'=>'Albanian','sr'=>'Serbian (Cyrillic)','sr'=>'Serbian (Latin)','sv'=>'Swedish','sv-fi'=>'Swedish (Finland)','sx'=>'Sutu','sz'=>'Sami (Lappish)','th'=>'Thai','tn'=>'Tswana','tr'=>'Turkish','ts'=>'Tsonga','uk'=>'Ukrainian','ur'=>'Urdu','ve'=>'Venda','vi'=>'Vietnamese','xh'=>'Xhosa','zh-cn'=>'Chinese (PRC)','zh-hk'=>'Chinese (Hong Kong SAR)','zh-sg'=>'Chinese (Singapore)','zh-tw'=>'Chinese (Taiwan)','zu'=>'Zulu'} },
      { name: 'hours:minutes', js: 'any_event && sitefoil.hours_minutes_int', 
        input_type: 'time',
        methods: ['==sitefoil.hours_minutes_to_int("?")','>=sitefoil.hours_minutes_to_int("?")','<=sitefoil.hours_minutes_to_int("?")','!=sitefoil.hours_minutes_to_int("?")'] },
      { name: 'date', js: 'any_event && sitefoil.date_int', 
        input_type: 'date',
        methods: ['==sitefoil.date_to_int("?")','>=sitefoil.date_to_int("?")','<=sitefoil.date_to_int("?")','!=sitefoil.date_to_int("?")'] },
      { name: 'page visit', js: 'page_load && ', methods: ['true'] },
      { name: 'page url', js: 'any_event && location.href', methods: ['=="?"'] },
      { name: 'element clicked id', js: 'any_event && el_clicked_id', methods: ['=="?"']},
			{ name: 'referrer', js: 'any_event && document.referrer', methods: ['=="?"','!="?"']},
	    { name: 'country', js: 'any_event && visitor.country', methods: ['=="?"','!="?"']},
	    { name: 'hour', js: 'any_event && visitor.hour', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'weekday number', js: 'any_event && vistor.weekday', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'visitor type', js: 'any_event && sitefoil.visitor_type()', methods: ['=="new"','=="returning"']},
	    { name: 'platform', js: 'any_event && visitor.device', methods: ['=="?"','!="?"'], possible_values: ['desktop','tablet','phone']},
      { name: 'operating system', js: 'any_event && visitor.os_name', methods: ['=="?"','!="?"'], possible_values: ['unknown','Windows','MacOS','Android','Linux','UNIX'] }
	  ]
	end

	def self.actions
    [
      { name: 'custom site footer', js: 'sitefoil.footer_show(":html")', params: [{name: :html, input_type: :textarea }] },
      { name: 'custom site banner', js: 'sitefoil.banner_show(":html")', params: [{name: :html, input_type: :textarea }] },
      { name: 'show hidden element', js: 'sitefoil.$(":selector").show()', params: [:selector]},
    	{ name: 'alert', js: 'alert(":message")', params: [:message] },
    	{ name: 'autofill', js: 'document.querySelector(":selector").value=":value"', params:[{name: :selector, input_type: :selector_pick},:value] },
    	{ name: 'send email', js: 'this.email_to(":to_email",":message")', params: [:to_email,:message] } 
    ]
  end

  def self.human_method js
  	ret = {
  	 '.one_of("?")'=>"one of",
     'true'=>'happen',
  	 '!="?"'=>'not equal',
  	 '!=?'=>'not equal',
  	 '==?'=>'equals', 
  	 '=="?"'=>'equals',
  	 '>=?'=>'bigger or equal', 
  	 '<=?'=>'lower or equal'}[js]
  	return ret if ret

  	if js.starts_with? '=="'
  		return "is "+js.gsub('=="','').gsub('"','')
  	end

    ret = {
      '==' => 'equals',
      '>=' => 'bigger or equal',
      '<=' => 'lower or equal',
      '!=' => 'not equal'
    }[js[0,2]]

    return ret if ret

  end

end
