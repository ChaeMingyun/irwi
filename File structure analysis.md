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
&nbsp;&nbsp;└[app](#app)   
&nbsp;&nbsp;&nbsp;└[views](#views)  
&nbsp;&nbsp;&nbsp;&nbsp;└[base_wiki_pages](#base_wiki_pages)  
&nbsp;&nbsp;└[lib](#lib-디렉토리)  
&nbsp;&nbsp;&nbsp;└[generator](#generator-디렉토리)  
&nbsp;&nbsp;&nbsp;&nbsp;└[irwi_wiki](#irwi_wiki)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[templates](#templates)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[controllers](#controllers)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[helpers](#helpers)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[migrate](#migrate)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[models](#models)  
&nbsp;&nbsp;&nbsp;&nbsp;└[irwi_wiki_attachment](#irwi_wiki_attachment)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[templates](#templates)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[migrate](#migrate)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[models](#models)  
&nbsp;&nbsp;&nbsp;&nbsp;└[irwi_wiki_view](#irwi_wiki_view)  
&nbsp;&nbsp;&nbsp;└[irwi](#irwi-디렉토리)   
&nbsp;&nbsp;&nbsp;&nbsp;└[comparators](#comparators)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[spans](#spans)  
&nbsp;&nbsp;&nbsp;&nbsp;└[extensions](#extensions-디렉토리)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[controllers](#controllers)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└[models](#models)  
&nbsp;&nbsp;&nbsp;&nbsp;└[formatters](#formatters)  
&nbsp;&nbsp;&nbsp;&nbsp;└[helpers](#helpers)  
&nbsp;&nbsp;&nbsp;&nbsp;└[paginators](#paginators)  
&nbsp;&nbsp;&nbsp;&nbsp;└[support](#support)  
&nbsp;&nbsp;└[spec](#Spec-디렉토리)  
&nbsp;&nbsp;&nbsp;└[comparators](#comparators-)  
&nbsp;&nbsp;&nbsp;└[extensions](#extensions-디렉토리)  
&nbsp;&nbsp;&nbsp;&nbsp;└[controllers](#controllers)  
&nbsp;&nbsp;&nbsp;&nbsp;└[models](#models)  
&nbsp;&nbsp;&nbsp;└[formatters](#formatters)  
&nbsp;&nbsp;&nbsp;└[helpers](#helpers)  
&nbsp;&nbsp;&nbsp;└[paginators](#paginators)  
&nbsp;&nbsp;&nbsp;└[support](#support)  

### lib 디렉토리
* irwi.rb  
가장 기본적인 로직이 담겨져 있다. 레일스에서 기본적으로 포함시켜주는 파일을 제외한 파일을 모두 require 시켜주고 있다.  
이 파일에 모든 로직을 다 집어넣을 수 있지만 그렇게 하다가는 파일이 엄청 길어지게 되므로, 다른 디렉토리와 파일로 나눠놓은 모양이다.  
> [autoload 명령어](http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html): 이 명령어는 앞에 써있는 객체를 호출했을때 require 시키는 방식이다. 호출 시키지 않으면  require 되지 않는다.

#### generator 디렉토리
이 부분은 기본적으로 [Rails Engine](http://guides.rubyonrails.org/engines.html)에 대한 개념이 있어야 이해할 수 있다.
#### irwi 디렉토리
* config.rb  
> [attr_ 명령어](http://stackoverflow.com/questions/5046831/why-use-rubys-attr-accessor-attr-reader-and-attr-writer): attr_writer 는 setter 이고 attr_reader 는 getter 이다.

Gem의 변수 기본값을 설정해준다. 이 값을 수정하여 Customization을 실현할 수 있다.
* formatter.rb  
변수 PROVIDERS를 정의한다. PROVIDERS는 마크다운 문법을 구현시키는 GEM의 목록을 배열의 형태로 담고 있다. autodetector 클래스를 이용해, Gem을 찾는 모양이다.
> include와 extend 명령어:
> [.freeze 명령어](http://apidock.com/ruby/Object/freeze): 다음과 같이 배열에 ["red_cloth", “red_carpet", "blue_cloth", "wiki_cloth", "simple_html"] 값이 할당 되어있으면 나중에 배열의 값이 변경되는 것을 방지해준다. 만약에 배열의 값을 변경하려고 시도한다면, RuntimeError 가 발생한다.

* helpers.rb  
이 파일은 기본적으로 헬퍼를 관리하는 파일이다.  
irwi/helper 디렉토리에 적어놓은 헬퍼 파일을 autoload 시킨다.  
그러고는 acts_as_wiki_pages_helper 메소드에 위에 불러온 헬퍼파일을 모두 include 시킨다.
* paginators.rb  
변수 PROVIDERS를 정의한다. PROVIDERS는 페이지네이션을 하는 GEM의 목록을 배열의 형태로 담고 있다. autodetector 클래스를 이용해, Gem을 찾는 모양이다.
* version.rb  
Rubygem에서 관리할 Gem의 버젼정보를 VERSION 변수에 담고 있다.

##### comparators 디렉토리
  Irwi::Comparators::Base 클래스에 위키에 수정이 가해졌을때 어느 부분이 추가되고 어느부분이 제거되었는지, 또 어느부분이 바뀌지 않았는지를 판별하고, 표시하는 메소드를 담고 있다.
  * base.rb  
  new_not_changed 메소드는 not_changed_span 클래스를 생성하면서 받은 파라미터 값을 집어넣고, new_changed 메소드는 changed_span 클래스를 생성하면서 받은 파라미터 값을 집어넣는다.  
  (한마디로 코드 길이 줄이기)
  * diff_lcs.rb  
  diff-lcs라는 Gem에 있는 Diff::LCS 클래스를 이용한다. base.rb 파일을 상속받는 Irwi::Comparators::DiffLcs 클래스는 initializer에 diff/lcs 파일을 require 시키는 것으로 보아, 그 내부의 로직을 initializer 메소드 안에서 실행시키는 듯 하다. private 이하에 써있는 메소드는 다른 파일에 적힌 span으로 변환하는 과정을 담아놓았다.
  * spans 디렉토리  
  이 디렉토리 내의 파일은 바뀐 내용을 span 안에 표시하기 위한 코드들이 각 파일명의 클래스로 담겨져 있다
  > alias는 기존의 메소드의 이름을 복제하는 문법이다.  
  ex) alias 새_이름, 기존_이름

    * changed_span.rb
    바뀐 부분에 대해서 removed 클래스를 갖는 span과 new 클래스를 갖는 span을 메소드 to_s를 호출했을때 불러온다.
    * not_changed_span.rb
    바뀌지 않은 부분에 대해서 action 메소드는 "="을 반환하고, old_value 와 new_value 메소드는 그냥 클래스가 생성될때 입력받은 값을 반환한다

##### extensions 디렉토리
* controllers.rb  
이 파일은 acts_as_wiki_pages_controller 라는 메소드에 WikiPages와 WikiPageAttachments 클래스를 include 하기 위해 작성되었다.  
두 클래스는 같은 위치상의 controllers 디렉토리안에 있다.
* models.rb  
이 파일은 acts_as_wiki_page, acts_as_wiki_page_version, acts_as_wiki_page_attachment 메소드에 각각
WikiPage, WikiPageVersion, WikiPageAttachment 클래스를 include 하기 위해 작성되었다.  
두 클래스는 같은 위치상의 models 디렉토리안에 있다.  
* controllers 디렉토리
  * wiki_page_attachments.rb
  파일을 관리하기 위한 model에 대해 적혀있다. 어떤 파일이 업로드 되면, Irwi.config.page_attachment_class 에 저장되어 있는 파일 목록이 적혀있는 모델의 클래스에 add_attachment가 호출되면 레코드를 집어넣고, remove_attachment가 호출되면 레코드를 삭제한다. 두 메소드 모두 페이지의 컨트롤러 역할을 하는 메소드이다.
  * wiki_pages.rb  
  이 파일은 WikiPages 모듈에 대해 적혀있다. controller에 보통 들어갈 내용이 적혀 있다.  
  템플릿 파인더 메소드를 이용해 Gem 외부에 View 파일이 있으면 불러오도록 설정해놓았다.  
  **WikiPageAttachment 클래스를 통해 파일 관리 페이지도 있으나.. 만들다 만듯하다?**
  또한 권한관리를 위해 있는 메소드인 allowed?류의 메소드 기본값이 적혀있다.
* models 디렉토리
  * wiki_page_attachment.rb  
  Paperclip을 사용하는 듯한 코드가 있으나 Gemspec에는 paperclip을 dependencies에 추가하지 않았다. 이는 제작자의 페이지상에서 paperclip을 사용했으나, attachment 관련된 부분은 구현하다가 말았거나 당사자의 프로젝트 안에서만 유효한 파일로 여겨진다.
  * wiki_page_version.rb  
  Model 중에 wiki_page_version 모델에 사용되는 내용을 담고 있다. sql문이 직접 사용되어, **no sql DB에서는 사용할시 에러가 일어날 가능성이 다분하다.**  
  우선 next 와 previous 메소드를 호출하면 같은 페이지의 다음 버젼과 이전 버젼이 호출되도록 하였다.**하지만 이 위키내에서 이 명령은 사용되지 않았고, 실제로 사용해본 결과 invalid value for Integer() 에러가 발생한다**  
  또한 수정이 일어나지 못하게 되어있다. 수정을 하게되면 ActiveRecordError가 발생한다.  
  between 이 scope로 처리되어 있는데 이 부분은 lib/irwi/extensions/controller/wiki_pages.rb:89 에서 사용되는 것을 확인하였다. 두 숫자 사이의 버젼을 불러오는듯 하다.
  * wiki_page.rb
  find_by_path_or_new 메소드는 모델의 path튜플에 검색해보고 없으면 새로 만드는 메소드입니다. lib/irwi/extensions/controllers/wiki_pages.rb:139 에 사용되었습니다.  
  last_version_number는 해당 페이지와 대응되는 WikiPageVersion의 number 튜플의 가장 마지막 값을 반환합니다.  
  또 Version record를 어디서 추가 하는지가 이 안에 있는데, after_save에 걸려있는 create_new_version 메소드를 이용해서 버젼을 기록합니다. 버젼의 내용은 단순하게 이전의 기록 정보를 그대로 담고 있습니다(**얼마나 달라졌는지의 차이를 담지는 않고 있습니다**)

##### formatters 디렉토리
##### helpers 디렉토리
##### paginators 디렉토리
##### support 디렉토리
* template_finder.rb  
View를 커스터마이제이션 한 경우 (rails g irwi_wiki_views) 그 파일을 가져다 쓰기 위해 작성된 파일
* autodetector.rb  
모르겠다ㅠㅠ<!--수정요망-->
* route_mapper.rb  
wiki의 라우팅 포인트를 지정해준다.

### Spec 디렉토리
Spec디렉토리는 테스트를 위한 코드를 모아놓았다

  #### comparators 디렉토리
  #### extensions 디렉토리
  #### formatters 디렉토리
  #### helpers 디렉토리
  #### paginators 디렉토리
  #### support 디렉토리


# 문법 설명

## Include vs Extend

include : 하나의 모듈에 있는 메소드를 다른 모듈이나 클래스에 Inject할 때 사용  
Extend : which adds module’s methods as instance methods, extend allows you to add them as a class methods.  

## attr_accessor 사용 이유  
 getter와 setter메소드와 함께 인스턴스 변수를 생성하기 위해 사용되는 루비의 주요 특징이다.

## module ClassMethods 는 왜 자꾸 쓰이나?
이 명령어는 꼭 extend ActiveSupport::Concern 과 함께 등장한다.  
왜 쓰이는지 진심 모르겠으나 한두번 본게 아니다.
