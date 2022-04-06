plaintext = 'rajatpar';
key = 'rajatpar';
% Converting it into 64 bit binary
binary_plaintext =  reshape(dec2bin(plaintext, 8).'-'0',1,[]);
disp(dec2hex(bin2dec(reshape(erase(num2str(binary_plaintext),' '),4,[]).')).')

fprintf("Encryption Output\n");

encrypted_message = encrypt_message(binary_plaintext,key);

fprintf("\nFinal encrypted message is \n");
disp(dec2hex(bin2dec(reshape(erase(num2str(encrypted_message),' '),4,[]).')).')

fprintf("\n \n")

fprintf("\nDecryption Output\n");

decrypted_message = decrypt_message(encrypted_message,key);
fprintf("The original plaintext is \n");
disp(dec2hex(bin2dec(reshape(erase(num2str(decrypted_message),' '),4,[]).')).')

function encrypted_message = encrypt_message(binary_plaintext,key)
    for i = 1:10
        binary_key = reshape(dec2bin(key, 8).'-'0',1,[]);
        binary_plaintext = execute_round(binary_plaintext,binary_key,i);
        disp(dec2hex(bin2dec(reshape(erase(num2str(binary_plaintext),' '),4,[]).')).')
    end
    encrypted_message = binary_plaintext;
end

function round_output = execute_round(round_pt,round_key,round_no)
    left_half = round_pt(1:32);
    right_half = round_pt(33:64);
    left_half = circshift(left_half,-round_no);
    key_left = round_key(1:32);
    key_right = round_key(33:64);
    left_half = bitxor(left_half,key_right);
    right_half = f_func(right_half,key_left);
    fprintf("Round %d done \n",round_no);
    round_output = [right_half left_half];
end

function f_output = f_func(right_half,key_left)
    f_output = bitxor(right_half,key_left);
end

function decrypted_message = decrypt_message(binary_ciphertext,key)
    %binary_ciphertext = circshift(binary_ciphertext,-32);
    for i = 1:10
        binary_key = reshape(dec2bin(key, 8).'-'0',1,[]);
        binary_ciphertext = execute_decryption_round(binary_ciphertext,binary_key,i);
        disp(dec2hex(bin2dec(reshape(erase(num2str(binary_ciphertext),' '),4,[]).')).')
    end
    decrypted_message = binary_ciphertext;
end

function round_output = execute_decryption_round(round_ct,round_key,i)
    key_left = round_key(1:32);
    key_right = round_key(33:64);
    left_half = round_ct(1:32);
    right_half = round_ct(33:64);


    left_half = bitxor(left_half,key_left);
    right_half = bitxor(right_half,key_right);


    right_half = circshift(right_half,11-i);
    fprintf("Round %d done \n",i);
    round_output = [right_half left_half];
end