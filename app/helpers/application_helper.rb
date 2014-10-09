module ApplicationHelper

	def self.trigger_channels
		['referrer']
	end

	def self.action_channels
		['input element']
	end


	def self.conditions
		[
      { name: 'page visit', js: '(page_load) && ', methods: ['true'] },
      { name: 'page url', js: '(page_load || el_click) && location.href', methods: ['=="?"'] },
      { name: 'element clicked id', js: '(el_click) && el_clicked_id', methods: ['=="?"']},
			{ name: 'referrer', js: '(page_load || el_click) && document.referrer', methods: ['=="?"','!="?"']},
	    { name: 'country', js: '(page_load || el_click) && visitor.country', methods: ['=="?"','!="?"']},
	    { name: 'hour', js: '(page_load || el_click) && visitor.hour', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'weekday number', js: '(page_load || el_click) && vistor.weekday', methods: ['==?','>=?','<=?','!=?']},
	    { name: 'visitor type', js: '(page_load || el_click) && visitor.state', methods: ['=="new"','=="returning"']},
	    { name: 'platform', js: '(page_load || el_click) && visitor.platform', methods: ['=="tablet"','=="desktop"','=="mobile"']}
	  ]
	end

	def self.actions
    [
      { name: 'show hidden element', js: 'sitefoil.$(":selector").show()', params: [:selector]},
    	{ name: 'alert', js: 'alert(":message")', params: [:message] },
    	{ name: 'autofill', js: 'document.querySelector(":selector").value=":value"', params:[:selector,:value] },
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


  end

end
