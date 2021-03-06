require File.dirname(__FILE__) + '/../environment'

def get(x, map = {}) #params_request = {}, params_session = {}, injection = {}, headers = {})
  init
  params = {:request => {}, :session => {}, :inject => {}, :headers => {}, :cookies => {}}.merge map
  @response = MockedHttpResponse.new
  @session = MockedHttpSession.new($context, params[:session], @session_id)
  @request = MockedHttpRequest.new(@session, x, Rhyme.translate(params[:request]), params[:inject], params[:headers], Locale.new('en', 'US'), params[:cookies])

  $filter.do_filter(@request, @response, $chain)
end

def init
  if !$init    
    $context = MockedServletContext.new
    
    $config = MockedFilterConfig.new($context)
    
    $filter = VRaptorFilter.new
    $filter.init($config)
    
    $chain = mock(FilterChain)
    
    $init = true
  end
  
end
