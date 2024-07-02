# seq_{start_number}_to_{end_number}
# start_number 부터 unsigned long long(8 byte)(18,446,744,073,709,551,615) 범위 까지의 시퀀스를 생성할 수 있다
SELECT * FROM seq_0_to_5;
/* 
    0
    1
    2
    3
    4
    5
*/

SELECT * FROM seq_5_to_0;
/*
    5
    4
    3
    2
    1
    0
*/