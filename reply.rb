require_relative 'questiondb.rb'
require_relative 'user.rb'
require_relative 'question.rb'

class Reply 

  attr_accessor :id, :question_id, :user_id, :parent_id, :reply_body

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

  def author
    name = QuestionsDatabase.instance.execute(<<-SQL, self.user_id)
      SELECT
        *
      FROM
          users
      WHERE 
          id = ? 
    SQL
    User.new(name.first) 
  end

  def question 
    name = QuestionsDatabase.instance.execute(<<-SQL, self.question_id)
      SELECT
        *
      FROM
          questions
      WHERE 
          id = ? 
    SQL
    Question.new(name.first) 
  end


  def parent_reply
    parent = QuestionsDatabase.instance.execute(<<-SQL, self.parent_id)
      SELECT
        *
      FROM
          replies
      WHERE 
          id = ? 
    SQL

    Reply.new(parent.first)
    
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
        replies
    WHERE 
        parent_id = ? 
   SQL
   
   children.map{ |reply| Reply.new(reply)}
  end
  


  

 
  
  
  
  
end