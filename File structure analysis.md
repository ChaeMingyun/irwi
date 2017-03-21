# About this file
이 파일은 irwi의 파일 구조를 분석하기 위해 작성되었습니다.
___
## About logic in this Gem
코드를 분석하기에 앞서, 빠른 구조파악을 위해 이 패키지의 기본적으로 눈에 띄는 기능을 정리해보자.
#### 글쓰기
이 패키지는 기본적으로 위키를 마크다운 형식으로 작성이 가능하도록 지원하고 있다. 하지만 그러기 위해서는 추가적인 Gem을 설치해야 한다.  
글을 쓰게 되면 처음 생성이 되었다는 의미가 wiki_page_version 이라는 모델에 저장된다.  
#### 수정하기/버젼관리
또한 다른 사람이 이제 글을 수정하게 되면 그 수정기록과 Diff(차이)가 wiki_page_version에 저장된다.
#### 목록보기
이 Gem은 목록을 보여주는 페이지에 Will_paginate나 kaminari 라는 Gem이 설치되어 있다면,페이지네이션이 구현되도록 하였다.
#### 권한관리
show_allowed?, history_allowed?, edit_allowed? 이 세가지 메소드를 오버라이딩 시켜서 권한 관리를 장려하고 있다.
___
## 디렉토리 분석
Irwi  
&nbsp;&nbsp;└app   
&nbsp;&nbsp;&nbsp;&nbsp;└views  
&nbsp;&nbsp;└[lib](#lib-디렉토리)  
&nbsp;&nbsp;&nbsp;&nbsp;└[generator](#generator-디렉토리)  
&nbsp;&nbsp;&nbsp;&nbsp;└[irwi](#irwi-디렉토리)  
&nbsp;&nbsp;└spec  
&nbsp;&nbsp;&nbsp;└[comparators] (#comparators-)
&nbsp;&nbsp;&nbsp;└extensions 
&nbsp;&nbsp;&nbsp;└formatters 
&nbsp;&nbsp;&nbsp;└helpers 
&nbsp;&nbsp;&nbsp;└paginators 
&nbsp;&nbsp;&nbsp;└support


### lib 디렉토리
* irwi.rb  
가장 기본적인 로직이 담겨져 있다. 레일스에서 기본적으로 포함시켜주는 파일을 제외한 파일을 모두 require 시켜주고 있다.  
이 파일에 모든 로직을 다 집어넣을 수 있지만 그렇게 하다가는 파일이 엄청 길어지게 되므로, 다른 디렉토리와 파일로 나눠놓은 모양이다.  
> [autoload 명령어](http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html): 이 명령어는 앞에 써있는 객체를 호출했을때 require 시키는 방식이다. 호출 시키지 않으면  require 되지 않는다.

#### generator 디렉토리
이 부분은 기본적으로 [Rails Engine](http://guides.rubyonrails.org/engines.html)에 대한 개념이 있어야 이해할 수 있다.
#### irwi 디렉토리
  * config.rb  
  Gem의 변수 기본값을 설정해준다. 이 값을 수정하여 Customization을 실현할 수 있다.
  * formatter.rb  
  변수 PROVIDERS를 정의한다. PROVIDERS는 마크다운 문법을 구현시키는 GEM의 목록을 배열의 형태로 담고 있다. autodetector 클래스를 이용해, Gem을 찾는 모양이다.
  > include와 extend 명령어:

  * helpers.rb  
  이 파일은 기본적으로 헬퍼를 관리하는 파일이다.  
  irwi/helper 디렉토리에 적어놓은 헬퍼 파일을 autoload 시킨다.  
  그러고는 acts_as_wiki_pages_helper 메소드에 위에 불러온 헬퍼파일을 모두 include 시킨다.
  * paginators.rb  
  변수 PROVIDERS를 정의한다. PROVIDERS는 페이지네이션을 하는 GEM의 목록을 배열의 형태로 담고 있다. autodetector 클래스를 이용해, Gem을 찾는 모양이다.
  * version.rb  
  Rubygem에서 관리할 Gem의 버젼정보를 VERSION 변수에 담고 있다.
  * comparators 디렉토리  
  Irwi::Comparators::Base 클래스에 위키에 수정이 가해졌을때 어느 부분이 추가되고 어느부분이 제거되었는지, 또 어느부분이 바뀌지 않았는지를 판별하고, 표시하는 메소드를 담고 있다.
  * extensions 디렉토리
    * controllers.rb  
    이 파일은 acts_as_wiki_pages_controller 라는 메소드에 WikiPages와 WikiPageAttachments 클래스를 include 하기 위해 작성되었다.  
    두 클래스는 같은 위치상의 controllers 디렉토리안에 있다.
    * models.rb  
    이 파일은 acts_as_wiki_page, acts_as_wiki_page_version, acts_as_wiki_page_attachment 메소드에 각각
    WikiPage, WikiPageVersion, WikiPageAttachment 클래스를 include 하기 위해 작성되었다.  
    두 클래스는 같은 위치상의 models 디렉토리안에 있다.  
    * controllers 디렉토리
    * models 디렉토리
  * support 디렉토리
    * template_finder.rb  
    View를 커스터마이제이션 한 경우 (rails g irwi_wiki_views) 그 파일을 가져다 쓰기 위해 작성된 파일
    * autodetector.rb  
    모르겠다ㅠㅠ<!--수정요망-->
    * route_mapper.rb  
    wiki의 라우팅 포인트를 지정해준다.
