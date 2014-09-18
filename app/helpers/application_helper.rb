module ApplicationHelper

	def self.trigger_channels
		['referrer']
	end

	def self.action_channels
		['input element']
	end


	def self.conditions
		[
			{ name: 'referrer', js: 'document.referrer', methods: ['=="?"']},
	    { name: 'country', js: 'visitor.country', methods: ['=="?"']},
	    { name: 'hour', js: 'visitor.hour', methods: ['==?','>=?','<=?']},
	    { name: 'weekday number', js: 'vistor.weekday', methods: ['==?','>=?','<=?']},
	    { name: 'visitor type', js: 'visitor.state', methods: ['=="new"','=="returning"']},
	    { name: 'platform', js: 'visitor.platform', methods: ['=="tablet"','=="desktop"','=="mobile"']}
	  ]
	end

	def self.actions
    [
    	{ name: 'alert', js: 'alert(":message")', params: [:message] },
    	{ name: 'set control value', js: 'document.querySelector(":selector").value=":value"', params:[:selector,:value] },
    	{ name: 'send email', js: 'email_to(":email",":message")', params: [:email,:message] } 
    ]
  end

  def self.human_method js
  	ret = {'==?'=>'equals', 
  	 '=="?"'=>'equals',
  	 '>=?'=>'bigger or equal', 
  	 '<=?'=>'lower or equal'}[js]
  	return ret if ret

  	if js.starts_with? '=="'
  		return "is "+js.gsub('=="','').gsub('"','')
  	end


  end

end
