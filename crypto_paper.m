plaintext = 'rajatpar';
key = 'rajatpar';
% Converting it into 64 bit binary
binary_plaintext =  reshape(dec2bin(plaintext, 8).'-'0',1,[]);

binary_key = reshape(dec2bin(key, 8).'-'0',1,[]);

for i = 1:10
    binary_plaintext = execute_round(binary_plaintext,binary_key,i);
    disp(dec2hex(bin2dec(reshape(erase(num2str(binary_plaintext),' '),4,[]).')).')
end

function round_output = execute_round(round_pt,round_key,round_no)
    left_half = round_pt(1:32);
    right_half = round_pt(33:64);
    left_half = circshift(left_half,-round_no);
    key_left = round_key(1:32);
    key_right = round_key(33:64);
    left_half = bitxor(left_half,key_left);
    right_half = f_func(right_half,key_right);
    round_output = [right_half left_half];
end

function f_output = f_func(right_half,key_right)
    f_output = bitxor(right_half,key_right);
end