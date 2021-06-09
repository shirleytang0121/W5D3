require_relative 'questiondb.rb'

class Reply 

  def self.find_by_user_id(user_id)
    user_reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT 
            *
        FROM 
          replies 
        WHERE
            user_id = ?
        SQL
        return nil if user_reply.empty?
       user_reply.map {|replies| Reply.new(replies)}
        
  end

  def self.find_by_question_id(question_id)
    q_reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT 
            *
        FROM 
            replies 
        WHERE
            question_id = ?
        SQL
        return nil if q_reply.empty?
       q_reply.map {|replies| Reply.new(replies)}
        
  end  
  




  def initialize( options )
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id'] 
    @parent_id = options['parent_id']
    @reply_body = options['reply_body']
 end
  

 
  
  
  
  
end