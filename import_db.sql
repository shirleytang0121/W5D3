PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users ( 
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    a_author_id INTEGER NOT NULL,
    FOREIGN KEY (a_author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    parent_id INTEGER,
    reply_body TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  users(fname,lname)
VALUES 
  ('Shirley','Tang'),
  ('Shirley','Tang'),
  ('Oscar', 'Vazquez'); 

INSERT INTO 
  questions(title, body, a_author_id)
VALUES
  ('confused','How do I do this project?', (SELECT id FROM users WHERE fname = 'Shirley')),
  ('lunch', 'Whats for lunch?', (SELECT id FROM users WHERE fname = 'Oscar')), 
  ('breakfast', 'Whats for breakfast?', (SELECT id FROM users WHERE fname = 'Oscar')), 
  ('dinner', 'Whats for dinner?', (SELECT id FROM users WHERE fname = 'Oscar')); 

  INSERT INTO 
    question_follows(user_id,question_id)
  VALUES
   ((SELECT id FROM users WHERE fname = 'Shirley'), (SELECT id FROM questions WHERE title = 'confused')),
   ((SELECT id FROM users WHERE fname = 'Oscar'), (SELECT id FROM questions WHERE title = 'lunch'));

  INSERT INTO 
    replies(question_id,user_id,parent_id,reply_body)
  VALUES 
    ((SELECT id FROM questions WHERE title = 'confused'), (SELECT id FROM users WHERE fname = 'Oscar'), NULL, 'Im just as confused'),
    ((SELECT id FROM questions WHERE title = 'confused'), (SELECT id FROM users WHERE fname = 'Shirley'), (SELECT id FROM replies WHERE reply_body = 'Im just as confused'), 'Something else' );


INSERT INTO 
  question_likes(question_id, user_id)
VALUES 
  ((SELECT id FROM questions WHERE title = 'lunch'), (SELECT id FROM users WHERE fname = 'Shirley')),
  ((SELECT id FROM questions WHERE title = 'lunch'), (SELECT id FROM users WHERE fname = 'Oscar'));
