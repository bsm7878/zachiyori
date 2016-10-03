class Contact < ApplicationMailer
    
    def welcome flyer, content
        email = mail from: flyer, 
                to: 'bsm7878@naver.com', 
                subject: '자취요리연구소',
                body: content
    end
    
end
