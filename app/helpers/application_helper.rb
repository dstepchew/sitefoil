module ApplicationHelper

	def self.trigger_channels
		['referrer']
	end

	def self.action_channels
		['input element']
	end


	def self.triggers
		[
      { name: 'language', js: 'any_event && sitefoil.language', methods: ['=="?"','!="?"'] },
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
	    { name: 'visitor type', js: 'any_event && visitor.state', methods: ['=="new"','=="returning"']},
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
