--OBS: Nao tenho certaza se fiz certo a atividade prática

CREATE TABLE Aluno (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F'))
);

CREATE TABLE Disciplina (
    codigo INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    creditos INT NOT NULL
);

CREATE TABLE Cursa (
    matricula INT,
    codigo INT,
    semestreAno VARCHAR(10) NOT NULL,
    nota DECIMAL(4, 2),
    faltas INT,
    PRIMARY KEY (matricula, codigo, semestreAno),
    FOREIGN KEY (matricula) REFERENCES Aluno(id),
    FOREIGN KEY (codigo) REFERENCES Disciplina(codigo)
);

INSERT INTO Aluno (id, nome, sexo) VALUES
(1, 'Joao Silva', 'M'),
(2, 'Maria Santos', 'F'),
(3, 'Carlos Lima', 'M'),
(4, 'Ana Oliveira', 'F'),
(5, 'Pedro Souza', 'M'),
(6, 'Sofia Alves', 'F'),
(7, 'Rafael Pereira', 'M'),
(8, 'Luana Fernandes', 'F'),
(9, 'Lucas Rodrigues', 'M'),
(10, 'Beatriz Costa', 'F');
select * from Aluno;


INSERT INTO Disciplina (codigo, nome, creditos) VALUES
(1, 'Estrutura de Dados', 4),
(2, 'Projeto Integrador', 6),
(3, 'Orientação a Objetos', 4),
(4, 'Requisitos de Software', 2),
(5, 'Sistema de Banco de Dados', 4);
select * from Disciplina;


INSERT INTO Cursa (matricula, codigo, semestreAno, nota, faltas) VALUES
(1, 1, '1/2021', 8.5, 0),
(2, 1, '1/2021', 4.0, 3),
(3, 2, '1/2021', 9.0, 1),
(4, 2, '2/2021', 7.8, 2),
(5, 3, '2/2021', 3.5, 4),
(6, 3, '2/2021', 8.2, 1),
(7, 1, '1/2022', 7.0, 0),
(8, 2, '1/2022', 4.2, 2),
(9, 4, '2/2022', 9.5, 0),
(10, 5, '2/2022', 8.8, 1);
select * from Cursa;

CREATE VIEW relatorioAcademico AS
SELECT 
    c.codigo AS codigo_disciplina,
    d.nome AS nome_disciplina,
    COUNT(c.matricula) AS numero_alunos,
    AVG(c.nota) AS media_notas,
    AVG(c.faltas) AS media_faltas
FROM 
    cursa c
JOIN 
    disciplina d ON c.codigo = d.codigo
GROUP BY 
    c.codigo, d.nome;

   
SELECT * FROM relatorioAcademico;
   
