use db_atividade_view;
/*
1. Exibir lista de alunos e seus cursos
Crie uma view que mostre o nome dos alunos e as disciplinas em que estão matriculados, incluindo o nome do curso.
*/

CREATE VIEW ListaAlunosDisciplinas AS
SELECT a.nome AS nome_aluno, d.nome AS disciplina, c.nome AS curso
FROM Alunos a
JOIN Matriculas m ON a.id = m.aluno_id
JOIN Disciplinas d ON m.disciplina_id = d.id
JOIN Cursos c ON d.curso_id = c.id;



/*
2. Exibir total de alunos por disciplina
Crie uma view que mostre o nome das disciplinas e a quantidade de alunos matriculados em cada uma.
*/

CREATE VIEW QuantidadeAlunosPorDisciplina AS
SELECT d.nome AS disciplina, COUNT(m.aluno_id) AS numero_alunos
FROM Matriculas m
JOIN Disciplinas d ON m.disciplina_id = d.id
GROUP BY d.nome;


/*
3. Exibir alunos e status das suas matrículas
Crie uma view que mostre o nome dos alunos, suas disciplinas e o status da matrícula (Ativo, Concluído, Trancado).
*/

CREATE VIEW StatusMatriculasAlunos AS
SELECT a.nome AS aluno, d.nome AS disciplina, m.status AS status_matricula
FROM Alunos a
JOIN Matriculas m ON a.id = m.aluno_id
JOIN Disciplinas d ON m.disciplina_id = d.id;


/*
4. Exibir professores e suas turmas
Crie uma view que mostre o nome dos professores e as disciplinas que eles lecionam, com os horários das turmas.
*/

CREATE VIEW ProfessoresTurmasHorarios AS
SELECT p.nome AS professor, d.nome AS disciplina, t.horario
FROM Professores p
JOIN Turmas t ON p.id = t.professor_id
JOIN Disciplinas d ON t.disciplina_id = d.id;


/*
5. Exibir alunos maiores de 20 anos
Crie uma view que exiba o nome e a data de nascimento dos alunos que têm mais de 20 anos.
*/

CREATE VIEW AlunosComMaisDe20Anos AS
SELECT nome, data_nascimento
FROM Alunos
WHERE YEAR(CURDATE()) - YEAR(data_nascimento) > 20;


/*
6. Exibir disciplinas e carga horária total por curso
Crie uma view que exiba o nome dos cursos, a quantidade de disciplinas associadas e a carga horária total de cada curso.
*/

CREATE VIEW CargaHorariaDisciplinasPorCurso AS
SELECT c.nome AS curso, COUNT(d.id) AS quantidade_disciplinas, SUM(d.carga_horaria) AS carga_horaria_total
FROM Cursos c
JOIN Disciplinas d ON c.id = d.curso_id
GROUP BY c.nome;


/*
7. Exibir professores e suas especialidades
Crie uma view que exiba o nome dos professores e suas especialidades.
*/

CREATE VIEW EspecialidadesProfessores AS
SELECT nome, especialidade
FROM Professores;


/*
8. Exibir alunos matriculados em mais de uma disciplina
Crie uma view que mostre os alunos que estão matriculados em mais de uma disciplina.
*/

CREATE VIEW AlunosComMultiplasDisciplinas AS
SELECT a.nome, COUNT(m.disciplina_id) AS total_disciplinas
FROM Alunos a
JOIN Matriculas m ON a.id = m.aluno_id
GROUP BY a.nome
HAVING COUNT(m.disciplina_id) > 1;


/*
9. Exibir alunos e o número de disciplinas que concluíram
Crie uma view que exiba o nome dos alunos e o número de disciplinas que eles concluíram.
*/

CREATE VIEW DisciplinasConcluidasPorAluno AS
SELECT a.nome, COUNT(m.disciplina_id) AS disciplinas_concluidas
FROM Alunos a
JOIN Matriculas m ON a.id = m.aluno_id
WHERE m.status = 'Concluído'
GROUP BY a.nome;


/*
10. Exibir todas as turmas de um semestre específico
Crie uma view que exiba todas as turmas que ocorrem em um determinado semestre (ex.: 2024.1).
*/

CREATE VIEW TurmasPorSemestreEspecifico AS
SELECT t.*
FROM Turmas t
WHERE t.semestre = '2024.1';


/*
11. Exibir alunos com matrículas trancadas
Crie uma view que exiba o nome dos alunos que têm matrículas no status "Trancado".
*/

CREATE VIEW AlunosComMatriculasTrancadas AS
SELECT a.nome
FROM Alunos a
JOIN Matriculas m ON a.id = m.aluno_id
WHERE m.status = 'Trancado';


/*
12. Exibir disciplinas que não têm alunos matriculados
Crie uma view que exiba as disciplinas que não possuem alunos matriculados.
*/

CREATE VIEW DisciplinasSemAlunosMatriculados AS
SELECT d.nome
FROM Disciplinas d
LEFT JOIN Matriculas m ON d.id = m.disciplina_id
WHERE m.aluno_id IS NULL;


/*
13. Exibir a quantidade de alunos por status de matrícula
Crie uma view que exiba a quantidade de alunos para cada status de matrícula (Ativo, Concluído, Trancado).
*/

CREATE VIEW QuantidadeAlunosPorStatus AS
SELECT m.status, COUNT(m.aluno_id) AS numero_alunos
FROM Matriculas m
GROUP BY m.status;


/*
14. Exibir o total de professores por especialidade
Crie uma view que exiba a quantidade de professores por especialidade (ex.: Engenharia de Software, Ciência da Computação).
*/

CREATE VIEW ProfessoresPorEspecialidade AS
SELECT p.especialidade, COUNT(p.id) AS numero_professores
FROM Professores p
GROUP BY p.especialidade;


/*
15. Exibir lista de alunos e suas idades
Crie uma view que exiba o nome dos alunos e suas idades com base na data de nascimento.
*/

CREATE VIEW IdadesAlunos AS
SELECT nome, YEAR(CURDATE()) - YEAR(data_nascimento) AS idade
FROM Alunos;

/*
16. Exibir alunos e suas últimas matrículas
Crie uma view que exiba o nome dos alunos e a data de suas últimas matrículas.
*/

CREATE VIEW UltimaMatriculaAlunos AS
SELECT a.nome, MAX(m.data_matricula) AS ultima_matricula
FROM Alunos a
JOIN Matriculas m ON a.id = m.aluno_id
GROUP BY a.nome;


/*
17. Exibir todas as disciplinas de um curso específico
Crie uma view que exiba todas as disciplinas pertencentes a um curso específico, como "Engenharia de Software".
*/

CREATE VIEW DisciplinasDeCursoEspecifico AS
SELECT d.nome AS disciplina, c.nome AS curso
FROM Disciplinas d
JOIN Cursos c ON d.curso_id = c.id
WHERE c.nome = 'Engenharia de Software';


/*
18. Exibir os professores que não têm turmas
Crie uma view que exiba os professores que não estão lecionando em nenhuma turma.
*/

CREATE VIEW ProfessoresSemNenhumaTurma AS
SELECT p.nome
FROM Professores p
LEFT JOIN Turmas t ON p.id = t.professor_id
WHERE t.professor_id IS NULL;


/*
19. Exibir lista de alunos com CPF e email
Crie uma view que exiba o nome dos alunos, CPF e email.
*/

CREATE VIEW AlunosCpfEmail AS
SELECT nome, cpf, email
FROM Alunos;


/*
20. Exibir o total de disciplinas por professor
Crie uma view que exiba o nome dos professores e o número de disciplinas que cada um leciona.
*/

CREATE VIEW DisciplinasPorProfessor AS
SELECT p.nome AS professor, COUNT(t.disciplina_id) AS numero_disciplinas
FROM Professores p
JOIN Turmas t ON p.id = t.professor_id
GROUP BY p.nome;