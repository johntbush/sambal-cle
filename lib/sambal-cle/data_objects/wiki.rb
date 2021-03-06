class WikiObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :title, :content, :site, :href

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :title=>random_alphanums,
      :content=>"{worksiteinfo}\n{sakai-sections}"
    }
    set_options(defaults.merge(opts))
    requires :site
  end

  alias :name :title

  def create
    open_my_site_by_name @site
    wiki
    on Rwiki do |home|
      home.edit
      @current_content = home.content.value
      @updated_content = "[#{@title}]\n\n"+@current_content
      home.content.set @updated_content
      home.save
      @href = home.wiki_href "#{@title}?"
      home.open_wiki "#{@title}?"
      home.edit
      home.content.set @content
      home.save
    end
  end

  def edit opts={}
    open_my_site_by_name @site
    wiki
    on Rwiki do |edit|
      edit.open_wiki @title
      edit.edit
      # TODO more here
    end
    set_options(opts)
  end

  def get_content
    open_my_site_by_name @site
    wiki
    on Rwiki do |edit|
      edit.open_wiki @title
      edit.edit
      @content = edit.content.value
    end
  end

end