create database store;
use store;
#创建商品表
drop database store;
create table production(
id int not null auto_increment,
name varchar(100) not null,
description text,
original_price DECIMAL(16, 4),
price DECIMAL(16, 4),
primary key(id)
);

#创建商品分类表
create table category(
id int not null auto_increment,
name varchar(40) not null,
primary key(id)
);



#创建商品和商品分类的关联表
create table production_category(
production_id int,
category_id int
);
insert into production(name, description, original_price, price)

	value('小黄书' , 'zyy最爱的绝版BL小说' , 100 , 199);
insert into production(name, description, original_price, price)

	value('外星人电脑' , '即使不是最牛逼的电脑，也是最贵的电脑' , 20000 , 18999);
insert into production(name, description, original_price, price)

	value('战地1' , '一战题材突突突游戏' , 199 , 99);
insert into production(name, description, original_price, price)

	value('小米mix' , '你有钱也买不到的手机' , 3199 , 3199);
insert into production(name, description, original_price, price)

	value('奥迪跑车' , '最终幻想15限量版奥迪跑车...模型' , 399 , 199);
insert into production(name, description, original_price, price)

	value('java编程思想' , '虽然有些人读了还是不会写代码，但真的是本好书' , 99 , 79);
insert into production(name, description, original_price, price)

	value('lego星球大战-千年隼' , '汉索罗的座驾' , 1999 , 1999);
insert into production(name, description, original_price, price)

	value('lego星球大战-死星' , '帝国大规模杀伤性武器' , 2999 , 2999);
insert into production(name, description, original_price, price)
    
    value('小米无人机' , '便宜是便宜，就是要小心炸机' , 1999 , 1999);


select *from production;





#用户表

create table users(
id int not null auto_increment,
name varchar(40) not null,
nickname varchar(100) not null,
mailbox varchar(40) not null,
address varchar(100) not null,
balance DECIMAL(16, 4) not null,
primary key(id)
);



#向用户表插入数据

insert into users(name,nickname,mailbox,address,balance) values('张昀怡','yi','boss1@bl.com','沪城环路1号',20000);
insert into users(name,nickname,mailbox,address,balance) values('梁绍焕','huan','huhuhu@huhu.com','沪城环路2号',20000);
insert into users(name,nickname,mailbox,address,balance) values('高成','cheng','xixixi@xixi.com','沪城环路3号',20000);
insert into users(name,nickname,mailbox,address,balance) values('宋天建','jian','lololo@lolo.com','沪城环路4号',20000);
insert into users(name,nickname,mailbox,address,balance) values('贾锐','rui','lalala@lala.com','沪城环路5号',20000);
insert into users(name,nickname,mailbox,address,balance) values('任向杰','jie','huohuohuo@huohuo.com','沪城环路6号',20000);
insert into users(name,nickname,mailbox,address,balance) values('彭佳辉','hui','hahaha@haha.com','沪城环路7号',20000);
insert into users(name,nickname,mailbox,address,balance) values('徐嘉亮','liang','heiheihei@heihei.com','沪城环路8号',20000);

#插入分类
insert into category(name) values('toy');
insert into category(name) values('game');
insert into category(name) values('book');
insert into category(name) values('electronic_products');

select * from category;

select * from production;

select * from users;



#向商品分类关联表插入数据

insert into production_category (production_id, category_id)
select p.id, c.id from production p, category c where p.name = '战地1' and c.name = 'game';

insert into production_category (production_id, category_id)
select p.id, c.id from production p, category c where p.name in ('战地1','奥迪跑车','lego星球大战-千年隼','lego星球大战-死星','小米无人机')and c.name = 'toy';

insert into production_category (production_id, category_id)
select p.id, c.id from production p, category c where p.name in ('小黄书','java编程思想') and c.name = 'book';

insert into production_category (production_id, category_id)
select p.id, c.id from production p, category c where p.name in ('外星人电脑','小米Mix','小米无人机') and c.name = 'electronic_products';

select * from users where nickname='jie';



#订单表
create table orderr(
id int not null auto_increment, 
create_date date not null,
address varchar(100) not null,
user_name varchar(20) not null,
state varchar(20) not null,
primary key(id)
);

#生成订单
create table orderr_production(
orderr_id int, 
production_id int, 
price decimal(16, 4),

count int
);

#任向杰进了商城，查看了一下自己的个人信息
select *from users where name='任向杰';
#查看了一下所有的电子产品
select * from production p,category c,production_category p_c 
where p.id=p_c.production_id and c.id=p_c.category_id and c.name='electronic_products';


insert into orderr(create_date,address,user_name,state) values ('2016-09-02','沪城环路6号','jie','未付款'); 
#然后把所有的电子产品都选上，生成了一个订单
insert into orderr_production(orderr_id,production_id,price,count)
select 1, p.id, p.price, 1
from production p, production_category p_c, category c where p.id = p_c.production_id 
and c.id = p_c.category_id
and c.name = 'electronic_products'; 

select * , po.price*po.count as allpay from orderr , orderr_production po where state = '未付款' ; 

select *from orderr_production;
#他看了下总价，发现买不起，只好退出了商城，留下了未付款的订单
select sum(count * price) from orderr_production where orderr_id=1;
#数学没学好的他想了想，又进来创了一个订单，这次选了外星人电脑和小米Mix，发现还是买不起
insert into orderr_production(orderr_id,production_id,price,count)
select 2, p.id, p.price, 1 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('外星人电脑','小米Mix');
#这次他选择了取消了订单，这张订单被移除掉了
delete from orderr_production where orderr_id like 2;

select*from orderr_production;
select*from orderr;

#他十分沮丧，决定学好知识，决定Java编程思想和小黄书各买一本回去学习，下订单
insert into orderr(create_date,address,user_name,state) values ('2016-09-11','沪城环路6号','jie','已付款'); 

insert into orderr_production(orderr_id,production_id,price,count)
select 2, p.id, p.price, 1 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('小黄书','java编程思想');


select *from orderr_production;

#老板娘看到小黄书卖不动，觉得可能是价格定太高，所以下调价格到了原价
update production set production.price = production.original_price where id in (1);
#守候多时的zyy赶紧跳了出来，下单买了10本小黄书

insert into orderr(create_date,address,user_name,state) values ('2016-09-02','沪城环路1号','yi','已付款'); 

insert into orderr_production(orderr_id,production_id,price,count)
select 3, p.id, p.price, 10 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('小黄书');





#任向杰进来看到小黄书买的原价了，他觉得自己好像买贵了，所以回去查看了一下自己的订单，发现果然买贵了
select * from orderr_production where orderr_id=2;

#为了迎接双十一的到来，老板娘决定先把所有商品都调回原价
update production set production.price = production.original_price;
select * from production;

#宋天健跑进来，发现线上居然比线下还买的贵，很气愤，创建了3个订单，每个订单都买了99台外星人电脑，然后不付款
insert into orderr(create_date,address,user_name,state) values ('2016-10-12','沪城环路4号','jian','未付款'); 

insert into orderr_production(orderr_id,production_id,price,count)
select 4, p.id, p.price, 99 from production p, production_category pc, category c 
where p.id = pc.production_id 
and c.id = pc.category_id
and p.name = '外星人电脑'; 


select * from orderr_production;


insert into orderr_production(orderr_id,production_id,price,count)
select 5, p.id, p.price, 99 from production p, production_category pc, category c 
where p.id = pc.production_id 
and c.id = pc.category_id
and p.name = '外星人电脑'; 
select*from orderr_production;

insert into orderr_production(orderr_id,production_id,price,count)
select 6, p.id, p.price, 99 from production p, production_category pc, category c 
where p.id = pc.production_id 
and c.id = pc.category_id
and p.name = '外星人电脑'; 
select*from orderr_production;

#贾锐最近书看完了，所 以跑到商城点开了图书分类，查看一下有什么书能买来看看
select * from production p,category c,production_category p_c 
where p.id=p_c.production_id and c.id=p_c.category_id and c.name='book';

#发现只有两本书，觉得好少，只好各买了10本，下单，付款
select*from users;

insert into orderr(create_date,address,user_name,state) values ('2016-10-15','沪城环路5号','rui','已付款'); 

insert into orderr_production(orderr_id,production_id,price,count)
select 7, p.id, p.price, 10 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('小黄书','java编程思想');


select *from orderr_production;
delete from orderr_production where orderr_id like 7;


#老板娘在双十一之前把所有商品，除了外星人电脑外，价格调整为原价的一半
update production p set p.price = p.original_price/2 where p.name != '外星人电脑';

#梁邵焕想买一台外星人，然后两张战地1回去和女朋友联机玩，但是钱不够，所以他和徐嘉亮借了5000块
update users set balance = balance + 5000 where name = '梁绍焕';
update users set balance = balance - 5000 where name = '徐嘉亮';
select*from orderr_production;

delete from orderr_production where orderr_id like 9;
#然后梁邵焕下单买了一台外星人电脑和两张战地1，付款
insert into orderr(create_date,address,user_name,state) values ('2016-11-11','沪城环路2号','huan','已付款'); 

insert into orderr_production(orderr_id,production_id,price,count)
select 8, p.id, p.price, 1 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('外星人电脑');
insert into orderr_production(orderr_id,production_id,price,count)
select 8, p.id, p.price, 2 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('战地1');

select *from orderr;


#高成买了台小米无人机，并下单付款
insert into orderr(create_date,address,user_name,state) values ('2016-11-11','沪城环路3号','cheng','已付款'); 

insert into orderr_production(orderr_id,production_id,price,count)
select 9, p.id, p.price, 1 from production p, production_category p_c, category c 
where p.id = p_c.production_id 
and c.id = p_c.category_id
and p.name in ('小米无人机');
#双11之前总的销售额
  select sum(o_p.price * o_p.count)双11之前总的销售额 from orderr_production o_p , 
  orderr o where o.create_date = '2016-9-02' and o_p.orderr_id=o.id and o.state = ('已付款');
#双11当天总的销售额
select sum(o_p.price * o_p.count)双11当天总的销售额 from orderr_production o_p , 
orderr o where o.create_date = '2016-11-11' and o_p.orderr_id=o.id and o.state = ('已付款');


#各种商品及他们销售量的列表

select *from orderr_production;
select p.name,op.count from production p left join orderr_production op
on op.production_id=p.id group by(p.name);

select p.name, ifnull(o.count, 0) as count from (select op.production_id as pid,sum(op.count) as count 
from orderr_production op ,orderr ord 
where op.orderr_id = ord.id and ord.state = '已付款' group by op.production_id) o 
right join production p on op_id = p.id;



select p.name, ifnull(sum(op.count), 0) as count
from  orders os 
inner join orders_production op on os.id = op.orders_id
right join production p on op.production_id = p.id 
where os.state = '已付款' or (os.state is null and os.id is null)
group by p.id;




select *from orderr_production;

#每个客户的订单数量的列表
select o.name,count(o_p.orderr_id) from orderr_production o_p,users o 
where o.id=o_p.orderr_id group by(o.name);

#订单金额最大的订单
select sum(o_p.orderr_id * o_p.price) as mostPayOrder , o.id  
from orderr_production o_p, orderr o where o_p.orderr_id = o.id 
group by o_p.orderr_id order by mostPayOrder desc limit 1;

#哪些商品至今销量为0














