create database atividade
default character set utf8mb4
default collate utf8mb4_general_ci;

create table clients (
id_cliente int primary key not null unique auto_increment,
nome varchar(100),
gmail varchar(50) unique
); 

create table products (
id_produto int primary key not null unique auto_increment,
nomes varchar(30),
princes varchar(10)
);


create table orders (
id_orders int primary key not null unique auto_increment,
tld int,
cld int,
dates date,
statu varchar(30)
);

create table productsche (
sId int,
pId int,
quantitys int
);


/*population*/

INSERT INTO clients(nome, princs) VALUES ("Laurindo","email@email");
INSERT INTO clients(nome, princs) VALUES ("Claudia","email1@email");
INSERT INTO clients(nome, princs) VALUES ("Laura","email2@email");

INSERT INTO products(nomes, princes) VALUES ("Ovo Frito","4.0");
INSERT INTO products(nomes, princes) VALUES ("Hamburger","10.0");
INSERT INTO products(nomes, princes) VALUES ("Picanha","200");
INSERT INTO products(nomes, princes) VALUES ("Café","45");

INSERT INTO orders(tld, cld, dates, statu) VALUES ("1","2","2025-03-29","'open'");
INSERT INTO orders(tld, cld, dates, statu) VALUES ("3","1","2025-03-01","'open'");

INSERT INTO productsche(sId, pId, quantitys) VALUES ("1","3","1");
INSERT INTO productsche(sId, pId, quantitys) VALUES ("1","2","2");
INSERT INTO productsche(sId, pId, quantitys) VALUES ("2","1","1");

/*a*/

SELECT 
    o.id_orders AS Pedido_ID,
    p.nomes AS Produto,
    ps.quantitys AS Quantidade
FROM 
    orders o
JOIN 
    productsche ps ON o.id_orders = ps.sId
JOIN 
    products p ON ps.pId = p.id_produto
WHERE 
    o.id_orders = <ID_DO_PEDIDO>;


/*b*/

DELIMITER $$

CREATE PROCEDURE LimitarPedidosEmAtendimento(IN idMesa INT)
BEGIN
    -- Verificar se a mesa está em atendimento
    DECLARE mesaStatus VARCHAR(30);
    
    SELECT statu INTO mesaStatus
    FROM orders
    WHERE tld = idMesa
    ORDER BY dates DESC
    LIMIT 1;

    -- Se o status for "open", permite a operação, caso contrário, impede
    IF mesaStatus = 'open' THEN
        -- Permitir a criação de novo pedido
        SELECT 'Mesa está em atendimento. Pedido pode ser feito.';
    ELSE
        -- Impedir novo pedido para mesa que não está em atendimento
        SELECT 'Mesa não está em atendimento. Não é possível realizar o pedido.';
    END IF;
END$$

DELIMITER ;
