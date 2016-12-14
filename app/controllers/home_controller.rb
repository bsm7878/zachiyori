class HomeController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :contact, :info, :privacy, :agreement, :email_send, :who_are_you, :choice]  #로그인 하지 않으면 index 제외 다른 페이지로 이동 불가
  
  	
  
  
  def index
     @user_count = User.all.count #총 회원가입 수
     @sell_count = Purchase.all.count #총 판매갯수
     
     doc = Nokogiri::HTML(open("https://www.facebook.com/zachiyori/"))
     @facebook_count = doc.css("._4cwn").inner_text[0] + doc.css("._4cwn").inner_text[2] + doc.css("._4cwn").inner_text[3] + doc.css("._4cwn").inner_text[4]

  end
  
  
  
  def practice #모의 결제 하기
    
  end
  
  
  
  def info # 자세한 정보 보기
    
  end
  
  
  def choice #step2 => 메뉴선택
    @mart_number = 1 #Address.where(:ok_address => current_user.address).take.mart_id
    @mart = Mart.where(:id => @mart_number).take
    
    Relax.where(:mart_id => @mart_number).exists?(:relax_date => Time.zone.now.to_s.split[0])
    
  end
  
  def option #step3 => 옵션선택
    
    if Time.zone.now.between?(Time.zone.now.midnight + Mart.find(1).start_time.hours, Time.zone.now.midnight + Mart.find(1).end_time.hours) 
      mart_number = Address.where(:ok_address => current_user.address).take.mart_id #해당마트 id 
      @need = Ready.where(:menu_id => params[:id]) #그 메뉴에 '필요한것' 갖가져오기
      @mart = Mart.find(mart_number) #해당 mart 정보 가져오기
      
      if @mart.menus.ids.include?(params[:id].to_i)
        @menu = Menu.find(params[:id])
      else
        redirect_to '/'
      end
    else
       redirect_to '/'
    end
  
  end
  
  def contact #연락_메일
    
  end
  
  def credit #결제하기 
  
    @imp = "imp96245329"
    @consumer_final_address = current_user.address + " " + current_user.sub_address #주문자 최종 주소
    @menu = Menu.find(params[:menu_id]) #주문 상품 

    if params[:bob] == "0" 
      @final_total_price =  @menu.menu_price
    else
      @final_total_price = @menu.menu_price + @menu.mart.bob_price
    end
      

  end
  
  def my_list #구매내역
    @purchase = Purchase.where(:user_id => current_user.id)
  end
  
  def privacy #개인정보 취급방침 페이지
    
  end
  
  def agreement #이용약관 페이지
    
  end
  
  def adjust_privacy #개인정보 수정
    
  end
  
  def adjust_privacy_save #개인정보 수정 저장
    pri = Privacy.where(:user_id => current_user.id).take
    pri.name = params[:adjust_name]
    pri.phone = params[:adjust_phone]
    pri.public_pw = params[:adjust_public_pw]
    pri.save
    flash[:success] = "개인정보가 수정되었습니다!"
    redirect_to :back
  end
  
  
  def adjust_address #주소 변경
    
  end
  
  def bye_bye #회원탈퇴
    
  end
  
  
  def comming_soon #결제완료
    
    if Time.zone.now.between?(Purchase.where(:user_id => current_user.id).last.created_at - 1.minutes, Purchase.where(:user_id => current_user.id).last.created_at + 15.seconds)
      
      @success = Purchase.where(:user_id => current_user.id).last #로그인 유저가 가장최근에 주문한것
      @success = Purchase.where(:user_id => current_user.id).last #로그인 유저가 가장최근에 주문한것
        if @success.option_1 == true
          bob = "오뚜기밥 2개 + 소스박스 + 레시피"
        else
          bob = "오뚜기밥 2개 + 소스박스 + 레시피" #행사기간에만 오뚜기밥2개!
        end
        
        mart_email = Mart.find(Menu.find(@success.menu_id).mart_id).mart_email
        title = "[" + "#{@success.created_at.to_s.split[0] + " " + @success.created_at.to_s.split[1]}" + "]"  + " "+"#{Menu.find(@success.menu_id).menu_name}" 
        
         ingredient = Array.new
         Menu.find(@success.menu_id).ingredients.each do |a|
           ingredient.push(a.ingredient_name + " " + a.ingredient_amount)
         end 
                                      
        name = "주문자: #{current_user.privacy.name}"
        menu = "주문메뉴: #{Menu.find(@success.menu_id).menu_name}"
        menu_ingredient = "재료: #{ingredient}"
        option = "옵션: #{bob}"
        address = "#{current_user.address + " " + current_user.sub_address}"
        public_pw = "공동현관비번: #{current_user.privacy.public_pw}"
        want_content =  "요구사항: #{@success.want_content}"
        phone = "#{current_user.privacy.phone}"
        p1 = "- 개인정보 보호를 위해 완료되고 하루 이내에 해당 메시지를 삭제해주세요."
        p2 = "- 삭제한 후에도 '자취요리연구소의 사장님페이지'에서 보실 수 있습니다."
        p3 = "- 더 궁금한 사항이 있으시면 언제든 연락주시면 감사하겠습니다. 010-8745-7983"
                   
        Contact.order(mart_email, title, name, menu, menu_ingredient, option, address, public_pw, want_content, phone, p1, p2, p3).deliver_now 
        #주문완료되면 알림가기 완료
      
    else
      redirect_to '/home/my_list'
    end
  end
  
  
  def bye_bye_save #회원탈퇴 확인
    
    if current_user.valid_password?(params[:password_confirm])
      user_delete = User.find(current_user.id)
      user_delete.destroy
      redirect_to '/'
    else
      redirect_to :back
    end
    
  end
  
  def adjust_address_save #주소변경
    adjst_address = User.find(current_user.id)
    adjst_address.address = params[:address]
    adjst_address.sub_address = params[:sub_address]
    adjst_address.save
    flash[:success] = "주소가 변경되었습니다!"
    redirect_to :back
  end
  
  def email_send #email
    flyer = params[:flyer]
    content = params[:content]
    Contact.welcome(flyer, content).deliver_now
    flash[:success] = "메일이 성공적으로 보내졌습니다!"
    redirect_to :back
    
  end
  
  ##################### 관리자 페이지 ##############################
  
  def manager #관리자페이지시작 => 협약 마트 모두보기
    if Access.where(:access_email => current_user.email).exists?
      @mart = Mart.all
    else
      redirect_to :back
    end
  end
  
  def mart #선택 마트 정보보기 => 레시피 추가, 재료 추가
    @mart = Mart.find(params[:id])
    @relax = Relax.where(:mart_id => @mart) #해당마트 휴무일 전체 
    
    menus = Mart.find(params[:id]).menu_ids #해당마트 메뉴 ids
    @buy = Purchase.where(:menu_id => menus) #전체 구매내역 불러오기
    
    
  end
  
  def order #개요-관리자페이지
    @menu = Mart.find(params[:id]).menus #선택된 마트의 메뉴 정보
    mart_menu = Mart.find(params[:id]).menus.ids
    Time.zone.now.to_s.split[0]
    @today_time =  Purchase.where(:menu_id => mart_menu).where(:save_time => Time.zone.now.to_s.split[0].to_datetime...Time.zone.now.to_s.split[0].to_datetime + 1.days)
    #@today_time = Purchase.where(:menu_id => mart_menu).where("DATE(created_at) = DATE(?)", Time.now)
  end
  

  
  def buy_total #정산내역-관리자페이지
    @menu = Mart.find(params[:id]).menus #선택된 마트의 메뉴 정보
    @mart_menu = Mart.find(params[:id]).menus.ids
    
  end
  
  def who_are_you #서비스소개
    
  end
  
  def graph #판매 통계보여주는 곳
  
    ######## 메뉴별 총 판매 갯수 ########
    @menu_1_name = Menu.find(1).menu_name
    @menu_2_name = Menu.find(2).menu_name
    @menu_3_name = Menu.find(3).menu_name
    @menu_4_name = Menu.find(4).menu_name
    
    @menu_1_count = Purchase.where(:menu_id => 1).count
    @menu_2_count = Purchase.where(:menu_id => 2).count
    @menu_3_count = Purchase.where(:menu_id => 3).count
    @menu_4_count = Purchase.where(:menu_id => 4).count
    
    
    ######## 일자별 판매 갯수 ########
    #mart = Mart.find(params[:id]).menus.ids
    #Purchase.where(:menu_id => mart).where()
    
    
    ######## 주문장소 마커 ########
    menu_marker = Mart.find(params[:id]).menus.ids
    @a = Purchase.where(:menu_id => menu_marker)
    
    @maker = Maker.where(:mart_id => params[:id])
    
    ######## 시간별 판매 갯수(전체) ########
    #save_hour = Purchase.where(:menu_id => mart).save_time.to_datetime.hour 
    #save_minute = Purchase.where(:menu_id => mart).save_time.to_datetime.minute 

    #save_hour == 8 && (1..15).include?(save_minute)
    #(16..30).include?(number)
    #(31..45).include?(number)
    #(46..59).include?(number)
    
    
    #Purchase.last.save_time.to_datetime.minute 


    ######## 시간별 판매 갯수(평일) ########
    
    ######## 시간별 판매 갯수(주말) ########
    
    
  end
  
  ##################### 저장하기 ##############################
  
  
  def mart_save #마트 정보 저장하기
    mart = Mart.new
    mart.mart_name = params[:mart_name]
    mart.mart_email = params[:mart_email]
    mart.mart_img = params[:mart_img]
    mart.mart_img2 = params[:mart_img2]
    mart.mart_leader = params[:mart_leader]
    mart.mart_number = params[:mart_number]
    mart.agreement_day = params[:agreement_day]
    mart.mart_address = params[:mart_address]
    mart.start_time = params[:start_time].to_i
    mart.end_time = params[:end_time].to_i
    mart.mart_phone = params[:mart_phone]
    mart.bob_price = params[:bob_price].to_i
    mart.bob_commission = params[:bob_commission].to_i
    mart.save
    redirect_to :back
  end
  
  def access_save #관리자 권한 저장
    
    access = Access.new
    access.access_email = params[:access_email]
    access.access_step = params[:access_step]
    access.save
    redirect_to :back
    
  end
  
  def menu_save
    menu = Menu.new
    menu.mart_id = params[:mart_id]
    menu.menu_name = params[:menu_name]
    menu.menu_say = params[:menu_say]
    menu.menu_price = params[:menu_price].to_i
    menu.menu_commission = params[:menu_commission].to_i
    
    menu.menu_img1 = params[:menu_img1]
    menu.menu_img2 = params[:menu_img2]
    menu.menu_img3 = params[:menu_img3]
    menu.menu_img4 = params[:menu_img4]
    menu.menu_choice = params[:menu_choice]
    menu.save
    redirect_to :back
  end
  
  def relax_save #마트휴무 설정
    relax = Relax.new
    relax.mart_id = params[:mart_id]
    relax.relax_date = params[:relax_date]
    relax.save
    redirect_to :back
  end
  
  def howto_save
    howto = Howto.new
    howto.menu_id = params[:menu_id]
    howto.howto_img = params[:howto_img]
    howto.save
    redirect_to :back
    
  end
  
  def ready_save
    ready = Ready.new
    ready.menu_id = params[:menu_id]
    ready.ready = params[:ready]
    ready.save
    redirect_to :back
  end
  
  def ingredient_save 
    ingredient = Ingredient.new
    ingredient.menu_id = params[:menu_id]
    ingredient.ingredient_name = params[:ingredient_name]
    ingredient.ingredient_amount = params[:ingredient_amount]
    ingredient.ingredient_country = params[:ingredient_country]
    ingredient.save
    redirect_to :back
  end
  
  def source_save
    
    source = Source.new
    source.menu_id = params[:menu_id]
    source.source_name = params[:source_name]
    source.source_amount = params[:source_amount]
    source.save
    redirect_to :back
    
  end
  
  def address_save
    address = Address.new
    address.mart_id = params[:id]
    address.ok_address = params[:ok_address]
    address.together_zone = params[:together_zone].to_i
    address.save
    redirect_to :back
  end
  
  def purchase_save #credit 페이지에서 저장하기
  
    #token을 가져오자!
    url = "https://api.iamport.kr/users/getToken"
    body = {
        imp_key: 3842921403225799,
        imp_secret: "NVMlNEa8xzqvRAYSUg7q45o1KFskZIeND08rFjzdT0JKBHCvXKW1Pl3z0vT0e8NS9VjOfT18TLSvsv0p"
    }

    result = HTTParty.post url, body: body
    toaken_number = result["response"]["access_token"]
    
 
    #우선 아임포트에서 결제됬는지 가져오자!
    information_uri = "https://api.iamport.kr/payments/#{params[:imp_uid]}?_token=#{toaken_number}"
    source2 = information_uri
    resp2 = Net::HTTP.get_response(URI.parse(source2))
    data3 = resp2.body
    result3 = JSON.parse(data3)
    
    
    if result3["response"]["status"] == "paid"
      if current_user.privacy.nil?
        privacy = Privacy.new
        privacy.user_id = current_user.id
        privacy.name = params[:name]
        privacy.phone = params[:phone]
        privacy.public_pw = params[:public_pw]
        privacy.save
      else
        pri = Privacy.where(:user_id => current_user).take
        pri.name = params[:name]
        pri.phone = params[:phone]
        pri.public_pw = params[:public_pw]
        pri.save
      end
      
        purchase = Purchase.new
        purchase.user_id = current_user.id
        purchase.menu_id = params[:menu_id]
        purchase.imp_uid = params[:imp_uid]
        purchase.together_zone = params[:together_zone].to_i
        purchase.credit_method = params[:credit_method]
        purchase.total_price = params[:total_price]
        purchase.want_content = params[:want_content]
        purchase.save_time = Time.zone.now
        if params[:option_1] == "0"
          purchase.option_1 = 0
        else
          purchase.option_1 = 1 
        end
        purchase.save
      
        render :text => ""
        else
          redirect_to '/home/sorry_credit?imp=' + params[:imp_uid] #결제가 안되면!
        end
  end
  
  def mobile_save
    
    #token을 가져오자!
    url = "https://api.iamport.kr/users/getToken"
    body = {
        imp_key: 3842921403225799,
        imp_secret: "NVMlNEa8xzqvRAYSUg7q45o1KFskZIeND08rFjzdT0JKBHCvXKW1Pl3z0vT0e8NS9VjOfT18TLSvsv0p"
    }

    result = HTTParty.post url, body: body
    toaken_number = result["response"]["access_token"]
    
 
    #우선 아임포트에서 결제됬는지 가져오자!
    information_uri = "https://api.iamport.kr/payments/#{params[:imp_uid]}?_token=#{toaken_number}"
    source2 = information_uri
    resp2 = Net::HTTP.get_response(URI.parse(source2))
    data3 = resp2.body
    result3 = JSON.parse(data3)
    
    
    if result3["response"]["status"] == "paid"
      if current_user.privacy.nil?
        privacy = Privacy.new
        privacy.user_id = current_user.id
        privacy.name = result3["response"]["buyer_name"] #params[:name]
        privacy.phone = result3["response"]["buyer_tel"] #params[:phone]
        privacy.public_pw = params[:public_pw]
        privacy.save
      else
        pri = Privacy.where(:user_id => current_user).take
        pri.name = result3["response"]["buyer_name"] #params[:name]
        pri.phone = result3["response"]["buyer_tel"] #params[:phone]
        pri.public_pw = params[:public_pw]
        pri.save
      end
      
        purchase = Purchase.new
        purchase.user_id = current_user.id
        purchase.menu_id = Menu.where(:mart_id => Address.where(:ok_address => current_user.address).take.mart_id).where(:menu_name => result3["response"]["name"] ).take.id #params[:menu_id] error
        purchase.imp_uid = params[:imp_uid]
        purchase.together_zone = Address.where(:ok_address => current_user.address).take.together_zone #params[:together_zone].to_i 
        purchase.credit_method = result3["response"]["pay_method"] #params[:credit_method] error
        purchase.total_price = result3["response"]["amount"] #params[:total_price] error
        purchase.want_content = params[:want_content] #error
        purchase.save_time = Time.zone.now
        if params[:option_1] == "0" #error
          purchase.option_1 = 0
        else
          purchase.option_1 = 1 
        end
        purchase.save
        #save
        
        
        redirect_to '/home/comming_soon'
      else
        redirect_to '/home/sorry_credit?imp=' + params[:imp_uid] #결제가 안되면!
      end
  end
  
  def sorry_credit #결제실패하면 뜨는 페이지!
    #token을 가져오자!
    url = "https://api.iamport.kr/users/getToken"
    body = {
        imp_key: 3842921403225799,
        imp_secret: "NVMlNEa8xzqvRAYSUg7q45o1KFskZIeND08rFjzdT0JKBHCvXKW1Pl3z0vT0e8NS9VjOfT18TLSvsv0p"
    }

    result = HTTParty.post url, body: body
    toaken_number = result["response"]["access_token"]
    
 
    #우선 아임포트에서 결제됬는지 가져오자!
    information_uri = "https://api.iamport.kr/payments/#{params[:imp]}?_token=#{toaken_number}"
    source2 = information_uri
    resp2 = Net::HTTP.get_response(URI.parse(source2))
    data3 = resp2.body
    result3 = JSON.parse(data3)
    
    @error = result3["response"]["fail_reason"] 
  
    
  end
  
  def menu_modify #menu.db 수정 => 메뉴선택
    menu_modify = Menu.find(params[:id])
    menu_modify.menu_choice = params[:choice]
    menu_modify.save
    redirect_to :back
  end
  
  def provide_save #레시피 카드 공급
    provide = Provide.new
    provide.menu_id = params[:id]
    provide.recipe = params[:recipe]
    provide.save
    redirect_to :back
  end
  
  def box_save #소스박스 공급 
    box = Box.new
    box.menu_id = params[:id]
    box.source_box = params[:source_box]
    box.save
    redirect_to :back
  end
  
  def makers_save #마커 표시를 위한 위도 경도 저장
    maker = Maker.new
    maker.mart_id = params[:mart_id]
    maker.latitude = params[:latitude]
    maker.longitude =  params[:longitude]
    maker.save
    redirect_to :back
  end
  
  
end
