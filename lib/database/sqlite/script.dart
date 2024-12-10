const createTable = '''
  CREATE TABLE contact(
    id INTEGER NOT NULL PRIMARY KEY
    ,nome VARCHAR(200) NOT NULL
    ,telefone CHAR(16) NOT NULL
    ,email VARCHAR(150) NOT NULL
    ,url_avatar VARCHAR(300) NOT NULL 
  )
'''; // Criação da tabela `contact` com colunas para ID, nome, telefone, email e URL do avatar.


const insert1 = '''
INSERT INTO contact (nome, telefone, email, url_avatar)
VALUES ('Pietro','(11) 9 9874-5656','pietro@email.com','https://media.istockphoto.com/id/1199374004/pt/foto/fun-3d-cartoon-asian-teenager.jpg?s=1024x1024&w=is&k=20&c=A6UoJLfP83DXR6FVQopbUJ-B5lmPqo0hJu2ZE1gW1kY=')
''';

const insert2 = '''
INSERT INTO contact(nome, telefone, email, url_avatar)
VALUES ('Maitê','(11) 9 9632-8578', 'maite@email.com','https://cdn.pixabay.com/photo/2021/01/17/09/11/woman-5924366_960_720.jpg')
''';

const insert3 = '''
INSERT INTO contact (nome, telefone, email, url_avatar)
VALUES ('Hortência','(11) 9 9562-3356','hortencia@email.com','https://cdn.pixabay.com/photo/2021/01/24/09/28/girl-5944691_960_720.jpg')
''';