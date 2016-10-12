class HomeController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :contact, :info, :privacy, :agreement, :email_send, :who_are_you]  #로그인 하지 않으면 index 제외 다른 페이지로 이동 불가
  
  	
  
  
  def index
  end
  
  def practice
    
  end
  def info # 자세한 정보 보기
    
  end
  
  
  def choice #step2 => 메뉴선택
    @mart_number = Address.where(:ok_address => current_user.address).take.mart_id
    @mart = Mart.where(:id => @mart_number).take
    
  end
  
  def option #step3 => 옵션선택
    
      mart_number = Address.where(:ok_address => current_user.address).take.mart_id
      
      if Mart.find(mart_number).menus.ids.include?(params[:id].to_i)
        @menu = Menu.find(params[:id])
        @price = @menu.ingredients.sum(:ingredient_price) - @menu.ingredients.last.ingredient_price
        @five_time = Time.zone.now.to_s.split[0] + " "  + "5시" #오늘 5시 주문 접수 들어감
        @seven_time = Time.zone.now.to_s.split[0] + " "  + "7시" #오늘 7시 주문 접수 들어감
        
        @next_five_time = (Time.zone.now + 1.days).to_s.split[0] + " "  + "5시" #내일 5시 주문 접수 들어감
        @next_seven_time = (Time.zone.now + 1.days).to_s.split[0] + " "  + "7시" #내일 7시 주문 접수 들어감
      else
        redirect_to '/'
      end
    
  end
  
  def contact #연락_메일
    
  end
  
  def credit #결제하기 
    @consumer_final_address = current_user.address + current_user.sub_address #주문자 최종 주소
    @menu = Menu.find(params[:menu_id]) #주문 상품 id
    basic_price = @menu.ingredients.sum(:ingredient_price) - @menu.ingredients.last.ingredient_price #상품 기본 가격
    
    if params[:bob] == "0" 
      if params[:source] == "0"
        @final_total_price =  basic_price
      else
        @final_total_price = basic_price + params[:source].to_i
      end
    else
      if params[:source] == "0"
        @final_total_price = basic_price + 1400
      else
        @final_total_price = basic_price + 1400 + params[:source].to_i
      end
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
    
    if Time.zone.now.between?(Purchase.where(:user_id => current_user.id).last.created_at - 1.minutes, Purchase.where(:user_id => current_user.id).last.created_at + 1.minutes )
      @success = Purchase.where(:user_id => current_user.id).last
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
    
  end
  
  def order #개요-관리자페이지
    @menu = Mart.find(params[:id]).menus #선택된 마트의 메뉴 정보
  end
  
  def buy_five #당일 5시 배송내역-관리자페이지
    @menu = Mart.find(params[:id]).menus #선택된 마트의 메뉴 정보
    @mart_menu = Mart.find(params[:id]).menus.ids
    @five_time = Purchase.where(:menu_id => @mart_menu).where(:deliver_time => "#{Time.zone.now.to_s.split[0]} 5시").order(:together_zone)
    @seven_time = Purchase.where(:menu_id => @mart_menu).where(:deliver_time => "#{Time.zone.now.to_s.split[0]} 7시").order(:together_zone)
  end
  
  def buy_seven #당일 7시 배송내역-관리자페이지
    @menu = Mart.find(params[:id]).menus #선택된 마트의 메뉴 정보
    @mart_menu = Mart.find(params[:id]).menus.ids
    @five_time = Purchase.where(:menu_id => @mart_menu).where(:deliver_time => "#{Time.zone.now.to_s.split[0]} 5시").order(:together_zone)
    @seven_time = Purchase.where(:menu_id => @mart_menu).where(:deliver_time => "#{Time.zone.now.to_s.split[0]} 7시").order(:together_zone)
  end
  
  def buy_total #정산내역-관리자페이지
    @menu = Mart.find(params[:id]).menus #선택된 마트의 메뉴 정보
    @mart_menu = Mart.find(params[:id]).menus.ids
    @five_time = Purchase.where(:menu_id => @mart_menu).where(:deliver_time => "#{Time.zone.now.to_s.split[0]} 5시").order(:together_zone)
    @seven_time = Purchase.where(:menu_id => @mart_menu).where(:deliver_time => "#{Time.zone.now.to_s.split[0]} 7시").order(:together_zone)
  end
  
  def who_are_you #서비스소개
    
  end
  
  ##################### 저장하기 ##############################
  
  
  def mart_save #마트 정보 저장하기
    mart = Mart.new
    mart.mart_name = params[:mart_name]
    mart.mart_email = params[:mart_email]
    mart.mart_img = params[:mart_img]
    mart.mart_leader = params[:mart_leader]
    mart.mart_number = params[:mart_number]
    mart.agreement_day = params[:agreement_day]
    mart.mart_address = params[:mart_address]
    mart.mart_time = params[:mart_time]
    mart.mart_phone = params[:mart_phone]
    mart.mart_img1 = params[:mart_img1]
    mart.mart_img2 = params[:mart_img2]
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
    menu.menu_img1 = params[:menu_img1]
    menu.menu_img2 = params[:menu_img2]
    menu.menu_img3 = params[:menu_img3]
    menu.menu_img4 = params[:menu_img4]
    menu.menu_choice = params[:menu_choice]
    menu.save
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
    ingredient.ingredient_price = params[:ingredient_price]
    ingredient.ingredient_amount = params[:ingredient_amount]
    ingredient.ingredient_country = params[:ingredient_country]
    ingredient.save
    redirect_to :back
  end
  
  def source_save
    
    source = Source.new
    source.menu_id = params[:menu_id]
    source.source_name = params[:source_name]
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
      pri.save
    end
    
      purchase = Purchase.new
      purchase.user_id = current_user.id
      purchase.menu_id = params[:menu_id]
      purchase.imp_uid = params[:imp_uid]
      purchase.together_zone = params[:together_zone].to_i
      purchase.deliver_time = params[:want_time]
      purchase.credit_method = params[:credit_method]
      purchase.total_price = params[:total_price]
      purchase.want_content = params[:want_content]
      
      if params[:option_1] == "0"
        purchase.option_1 = 0
      else
        purchase.option_1 = 1 
      end
        
      if params[:option_2] == "0"
        purchase.option_2 = 0
      else
        purchase.option_2 = 1
      end

      purchase.save
      
    
    render :text => ""
    
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
  
end
