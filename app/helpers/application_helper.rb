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
      { name: 'conversion rate percent', js: 'site.conversion_rate', methods: ['==?','>=?','<=?'], input_type: :number},
      { name: 'conversion rate percent (last 24 hours)', js: 'site.conversion_rate_24_hours', methods: ['==?','>=?','<=?'], input_type: :number},
      { name: 'transactions (order count)', js: 'site.order_count', methods: ['==?','>=?','<=?'], 
        input_type: :number},
      { name: 'ip address', js: 'visitor.ip', methods: ['=="?"','!="?"'] },
      { name: 'language', js: 'sitefoil.language.toLowerCase()', methods: ['=="?"','!="?"'], possible_values:{'af'=>'Afrikaans','ar-ae'=>'Arabic (U.A.E.)','ar-bh'=>'Arabic (Bahrain)','ar-dz'=>'Arabic (Algeria)','ar-eg'=>'Arabic (Egypt)','ar-iq'=>'Arabic (Iraq)','ar-jo'=>'Arabic (Jordan)','ar-kw'=>'Arabic (Kuwait)','ar-lb'=>'Arabic (Lebanon)','ar-ly'=>'Arabic (Libya)','ar-ma'=>'Arabic (Morocco)','ar-om'=>'Arabic (Oman)','ar-qa'=>'Arabic (Qatar)','ar-sa'=>'Arabic (Saudi Arabia)','ar-sy'=>'Arabic (Syria)','ar-tn'=>'Arabic (Tunisia)','ar-ye'=>'Arabic (Yemen)','be'=>'Belarusian','bg'=>'Bulgarian','ca'=>'Catalan','cs'=>'Czech','da'=>'Danish','de'=>'German (Standard)','de-at'=>'German (Austria)','de-ch'=>'German (Switzerland)','de-li'=>'German (Liechtenstein)','de-lu'=>'German (Luxembourg)','el'=>'Greek','en'=>'English','en'=>'English (Caribbean)','en-au'=>'English (Australia)','en-bz'=>'English (Belize)','en-ca'=>'English (Canada)','en-gb'=>'English (United Kingdom)','en-ie'=>'English (Ireland)','en-jm'=>'English (Jamaica)','en-nz'=>'English (New Zealand)','en-tt'=>'English (Trinidad)','en-us'=>'English (United States)','en-za'=>'English (South Africa)','es'=>'Spanish (Spain)','es-ar'=>'Spanish (Argentina)','es-bo'=>'Spanish (Bolivia)','es-cl'=>'Spanish (Chile)','es-co'=>'Spanish (Colombia)','es-cr'=>'Spanish (Costa Rica)','es-do'=>'Spanish (Dominican Republic)','es-ec'=>'Spanish (Ecuador)','es-gt'=>'Spanish (Guatemala)','es-hn'=>'Spanish (Honduras)','es-mx'=>'Spanish (Mexico)','es-ni'=>'Spanish (Nicaragua)','es-pa'=>'Spanish (Panama)','es-pe'=>'Spanish (Peru)','es-pr'=>'Spanish (Puerto Rico)','es-py'=>'Spanish (Paraguay)','es-sv'=>'Spanish (El Salvador)','es-uy'=>'Spanish (Uruguay)','es-ve'=>'Spanish (Venezuela)','et'=>'Estonian','eu'=>'Basque (Basque)','fa'=>'Farsi','fi'=>'Finnish','fo'=>'Faeroese','fr'=>'French (Standard)','fr-be'=>'French (Belgium)','fr-ca'=>'French (Canada)','fr-ch'=>'French (Switzerland)','fr-lu'=>'French (Luxembourg)','ga'=>'Irish','gd'=>'Gaelic (Scotland)','he'=>'Hebrew','hi'=>'Hindi','hr'=>'Croatian','hu'=>'Hungarian','id'=>'Indonesian','is'=>'Icelandic','it'=>'Italian (Standard)','it-ch'=>'Italian (Switzerland)','ja'=>'Japanese','ji'=>'Yiddish','ko'=>'Korean','ko'=>'Korean (Johab)','lt'=>'Lithuanian','lv'=>'Latvian','mk'=>'Macedonian (FYROM)','ms'=>'Malaysian','mt'=>'Maltese','nl'=>'Dutch (Standard)','nl-be'=>'Dutch (Belgium)','no'=>'Norwegian (Bokmal)','no'=>'Norwegian (Nynorsk)','pl'=>'Polish','pt'=>'Portuguese (Portugal)','pt-br'=>'Portuguese (Brazil)','rm'=>'Rhaeto-Romanic','ro'=>'Romanian','ro-mo'=>'Romanian (Republic of Moldova)','ru'=>'Russian','ru-mo'=>'Russian (Republic of Moldova)','sb'=>'Sorbian','sk'=>'Slovak','sl'=>'Slovenian','sq'=>'Albanian','sr'=>'Serbian (Cyrillic)','sr'=>'Serbian (Latin)','sv'=>'Swedish','sv-fi'=>'Swedish (Finland)','sx'=>'Sutu','sz'=>'Sami (Lappish)','th'=>'Thai','tn'=>'Tswana','tr'=>'Turkish','ts'=>'Tsonga','uk'=>'Ukrainian','ur'=>'Urdu','ve'=>'Venda','vi'=>'Vietnamese','xh'=>'Xhosa','zh-cn'=>'Chinese (PRC)','zh-hk'=>'Chinese (Hong Kong SAR)','zh-sg'=>'Chinese (Singapore)','zh-tw'=>'Chinese (Taiwan)','zu'=>'Zulu'} },
      { name: 'hours:minutes', js: 'sitefoil.hours_minutes_int', 
        input_type: :time,
        methods: ['==sitefoil.hours_minutes_to_int("?")','>=sitefoil.hours_minutes_to_int("?")','<=sitefoil.hours_minutes_to_int("?")','!=sitefoil.hours_minutes_to_int("?")'] },
      { name: 'date', js: 'sitefoil.date_int', 
        input_type: :date,
        methods: ['==sitefoil.date_to_int("?")','>=sitefoil.date_to_int("?")','<=sitefoil.date_to_int("?")','!=sitefoil.date_to_int("?")'] },
      { name: 'page visit', js: '', methods: ['true'] },
      { name: 'page url', js: 'true', methods: ['==sitefoil.page_url_match("?")', '!=sitefoil.page_url_match("?")'] },
      { name: 'element clicked id', js: 'el_clicked_selector', methods: ['=="?"'],
        input_type: :selector_pick },
			{ name: 'referrer', js: 'document.referrer', methods: ['=="?"','!="?"']},
	    { name: 'country', js: 'visitor.country', methods: ['=="?"','!="?"']},
	    { name: 'hour', js: 'visitor.hour', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'weekday number', js: 'vistor.weekday', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'visitor type', js: 'sitefoil.visitor_type()', methods: ['=="new"','=="returning"']},
	    { name: 'platform', js: 'visitor.device', methods: ['=="?"','!="?"'], possible_values: ['desktop','tablet','phone']},
      { name: 'operating system', js: 'visitor.os_name', methods: ['=="?"','!="?"'], possible_values: ['unknown','Windows','MacOS','Android','Linux','UNIX'] }
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
      { name: 'custom site footer', js: 'sitefoil.footer_show(":html")', params: [{name: :html, input_type: :textarea }] },
      { name: 'welcome banner', js: 'sitefoil.banner_show(":html")', params: [{name: :html, input_type: :textarea }] },
      { name: 'welcome popup', js: 'sitefoil.popup_show({html: ":html", once_per_session: :once_per_session, recipe_id: recipe_id})', params: [{name: :html, input_type: :textarea },{name: :once_per_session, caption: "show only once per session", input_type: :checkbox}] },
      { name: 'show hidden element', js: 'sitefoil.$(":selector").show()', params: [:selector]},
    	{ name: 'alert', js: 'alert(":message")', params: [:message] },
    	{ name: 'autofill', js: 'document.querySelector(":selector").value=":value"', params:[{name: :selector, input_type: :selector_pick},:value] },
      { name: 'autofill and submit', js: 'sitefoil.autofill_and_submit(":selector",":value")', params:[{name: :selector, input_type: :selector_pick},:value]},
    	{ name: 'send email', js: 'this.email_to(":to_email",":message")', params: [:to_email,:message] },
      { name: 'console log', js: 'console.log(":message")', params: [:message]}
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
