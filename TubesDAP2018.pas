program tubes;
uses crt,sysutils;
type
     date = record
            dd: integer;
            mm: integer;
            yy: integer;
end;
type
       DaftMember = record
          nama: string;
          tahun: shortint;
          tanggal:Date;
end;
type
        film = record
            nama_movie : string;
            genre : string;
            tiket:LongInt;
            sisa:integer;
end;
type
        film_tayang = record
        filmt : film;
        studio : integer;
        jam : real;
        kursi : array [1..5,1..10] of string;
end;
type
        array_movie = array [1..10] of film;
        array_mov_tayang = array [1..10] of film_tayang;
                seat= array[1..50] of string;

//CETAK TIKET

procedure ctiket(var tayang:array_mov_tayang;indeks:integer;bangku:seat;i:integer);
var
        j:integer;
begin
        writeln;
        for j:=1 to i do
        begin
                writeln('   [<>]================================================[<>]');
                writeln('    ||                    -CITYNEMA-                    ||');
                writeln('   [<>]================================================[<>]');
                writeln('        Judul     : ',tayang[indeks].filmt.nama_movie);
                writeln('        Jam       : ',tayang[indeks].jam:0:2);
                writeln('        Kursi     : ',bangku[j]);
                writeln('   [<>]================================================[<>]');
        end;
        readln;
end;

//INPUT STOCK FILM

procedure input_movie(var array_infil:array_movie;var a:integer);
 var
        jwb:char;
 begin
        clrscr;
        writeln('[*]=================== INPUTAN MOVIE ===================[*]');
        repeat
                a:=a+1;
                writeln('     <>========================================<>');
                write('          Movie ',a,' : ');
    readln(array_infil[a].nama_movie);
                write('          Genre   : ');
    readln(array_infil[a].genre);
                write('          Tiket   : ');
                readln(array_infil[a].tiket);
                writeln('     <>========================================<>');
                write('          input lagi Y/N ');
                readln(jwb);
                writeln;
        until (jwb='N') or (jwb='n');
  writeln('[*]=====================================================[*]');
        readln;
 end;

//SEARCHING MOVIE
 function search_mov(data:array_movie; nama:string):film;
 var
    i:integer;
    filmnya:film;
                found:boolean;
begin
        for i:=1 to 10 do
        begin
            if (nama=data[i].nama_movie) then
            begin
        filmnya:=data[i];
            end;
        end;

  search_mov:=filmnya;
end;

//SEARCHING BANGKU
procedure serbang(var data:array_mov_tayang;indeks:integer;a:string;b:string;var fund:boolean);
 var
                x:string;
                k:string;
                found:boolean;
                i,j:integer;
begin
        k:=a+b;
        x:='';
        i:=1;
          found:=false;
        while ((i<=5) and (found=false)) do
        begin
                j:=1;
                while ((j<=10) and (found=false)) do
                begin
                        if (data[indeks].kursi[i,j]=k) then
                        begin
                                fund := true;
                                found:=true;
                                writeln('SUDAH TERISI');
                        end
                        else if (data[indeks].kursi[i,j]=x) then
                        begin
                                fund := false;
                                found:=true;
                                data[indeks].kursi[i,j]:=k;
                        end;
                        j:=j+1
                end;
                i:=i+1;
        end;
end;

//INPUT DAFTAR TAYANG

procedure tambah_tayang(var array_intay:array_mov_tayang ; dataFilm : array_movie;var jumlah:integer);
 var            nama:string;
                a :integer;
    pilih:char;
    filmx:film;
begin

        clrscr;
        a:=1;
        repeat
                          filmx.nama_movie:='null';
        writeln('[*]===========================================================[*]');
                        while filmx.nama_movie<>nama do
                        begin
                write('   Masukan Judul Film : ');
                readln(nama);
                filmx:=search_mov(dataFilm,nama);
                  end;
        array_intay[a].filmt:=filmx;
        write('   Studio : ');
        readln(array_intay[a].studio);
        write('   Jam Tayang : ');
        readln(array_intay[a].jam);
                          writeln;
                          writeln('   press Enter to continue');
                          writeln('   press N to end');
                          readln(pilih);
                          jumlah:=a;
                          a:=a+1;
        writeln('[*]===========================================================[*]');
                          readln;
        until (pilih='N') or (pilih='n');
end;

//SORTING JADWAL TAYANG
procedure urut(var tayang:array_mov_tayang;bft:integer);
var
        i,j:integer;
        temp:film_tayang.nama_movie;
begin
        i:=1;
        while i<=bft-1 do
        begin
                j:=1;
                while j<=bft-i do
                begin
                        if (tayang[j].nama_movie > tayang[j+1].nama_movie) then
                        begin
                                temp:=tayang[j];
                                tayang[j]:=tayang[j+1];
                                tayang[j+1]:=temp;
                        end;
                        j:=j+1;
                end;
                i:=i+1;
        end;
end;


//MENAMPILKAN JADWAL

procedure tampil_jadwal(var tayang:array_mov_tayang;bft:integer);
var
        i,j:integer;
        k:string;
begin
        clrscr;
        urut(tayang,bft);
        i:=1;
        k:='';
        while (tayang[i].filmt.nama_movie<>k) do
        begin
                writeln('                              [*]===================[=',i,'=]======================[*]');
                writeln('                                  Studio    : ',tayang[i].studio);
                writeln('                                  Nama Film : ',tayang[i].filmt.nama_movie);
                writeln('                                  Genre     : ',tayang[i].filmt.genre);
                writeln('                                  Waktu     : ',tayang[i].jam:0:2);
                i:=i+1;
                writeln('                              [*]=====================[=^=]======================== [*]');
                writeln;
        end;
end;


//MENGHAPUS STOCK FILM
procedure delete(var data:array_movie;n:integer);
var
        i,j:integer;
begin
        writeln('   =============================================');
        write('      Masukan Pilihan Film Yang Ingin Di Hapus :');
        readln(i);
        writeln('   =============================================');
        writeln;
        for j:=i to n do
        begin
                data[j]:=data[j+1];
        end;
end;

//MENAMPILKAN BANGKU TERISI
 procedure bangku_isi(var data:array_mov_tayang;indeks:integer);
 var
        i,j:integer;
 begin
        writeln('[<]=============== Daftar Bangku Yang Sudah Terisi ===============[>]');
        for i:=1 to 5 do
        begin
                if i=1 then
                begin
                        for j:=1 to 10 do
                        begin
                                write('   ',data[indeks].kursi[i,j],' , ');
                        end;
                end
                else if (i>i-1) then
                begin
                        for j:=1 to 10 do
                        begin
                                  write('   ',data[indeks].kursi[i,j],' , ');
                        end;
                end;
                writeln;
        end;
        writeln('[<]===============================================================[>]');
 end;

//MEMILIH BANGKU
procedure pil_bangku(var tayang:array_mov_tayang;var indeks,ticket:integer);
var
  pilih,jawab : string;
        f:boolean;
  a:seat;
        j,i,k,sisa,hasil : integer;
  jwb:string;
        kurs:string;
 begin
          clrscr;
          writeln;
    writeln('                             [=======================================================]');
    writeln('                             |                       PILIH KURSI                     |');
    writeln('                             |_______________________________________________________|');
    writeln('                             |                                                       |');
    writeln('                             |A10| |A9| |A8| |A7| |A6|        |A5| |A4| |A3| |A2| |A1|');
    writeln('                             |B10| |B9| |B8| |B7| |B6|        |B5| |B4| |B3| |B2| |B1|');
    writeln('                             |C10| |C9| |C8| |C7| |C6|        |C5| |C4| |C3| |C2| |C1|');
    writeln('                             |D10| |D9| |D8| |D7| |D6|        |D5| |D4| |D3| |D2| |D1|');
    writeln('                             |E10| |E9| |E8| |E7| |E6|        |E5| |E4| |E3| |E2| |E1|');
    writeln('                             [=======================================================]');
    readln;
          clrscr;
          bangku_isi(tayang,indeks);
    write('Jumlah : ');
    readln(i);
          tayang[indeks].filmt.sisa:=tayang[indeks].filmt.sisa+i;
    for j:=1 to i do
    begin
                        f := true;
                        while (f = true) do
                        begin
                                writeln('<>=============================<>');

              write('  Pilih Deret : ');
              readln(pilih);
                                write('  Pilih Nomor : ');
                                 readln(jawab);
                                serbang(tayang,indeks,pilih,jawab,f);
                                writeln('<>=============================<>');
                                writeln;
                                if f=false then
                                begin
                                        kurs:=pilih+jawab;
                                        a[j]:=kurs;
                                end;
                        end;
          end;
          clrscr;
          writeln('[*]=========================================================[*]');
          writeln('                      PENCETAKAN TIKET     ');
          writeln('[*]=========================================================[*]');
          ctiket(tayang,indeks,a,i);
          WRITELN('Harga yang Harus di Bayar : Rp ',30000*i);
          readln;
 end;

//MENAMPILKAN STOCK FILM

procedure view(var data:array_movie;a:integer);
var
        i,k:integer;
begin
        writeln('                                                  ======================================================');
        writeln('                                                  |                  DAFTAR MOVIE                      |');
        writeln('                                                  ======================================================');
        for i:=1 to a do
        begin
                writeln('                                                  ',i,'. Movie ',i,' : ',data[i].nama_movie);
                writeln('                                                    Genre ',i,' : ',data[i].genre);
                writeln('                                                    Tiket ',i,' : ',data[i].tiket);
        end;
        writeln('                                                  ======================================================');
        writeln('                                                  |                                                    |');
        writeln('                                                  ======================================================');
        readln;
end;

//MENU TAMBAHAN

procedure submenu1(var tyg:array_mov_tayang; var mov:array_movie;var bft:integer;var a:integer);
var
        chs:char;
        i:integer;
begin
        clrscr;
        i:=1;
        repeat
                clrscr;
                writeln('    1. Input Movie           ');
                writeln('    2. Remove Movie          ');
                writeln('    3. Tampilkan Daftar Movie');
                writeln('    4. Input Jadwal tayang   ');
                writeln('    0. EXIT                  ');
                write(' Pilih : ');
                readln(chs);
                if chs = '1' then
                begin
                        input_movie(mov,a);
                end
                else if chs = '2' then
                begin
                        clrscr;
                        while i<=a do
                        begin
                                writeln(i,'. Movie ',i,' : ',mov[i].nama_movie);
                                i:=i+1;
                        end;
                        writeln;
                        delete(mov,a);
                        readln;
                end
                else if chs = '3' then
                begin
                        view(mov,a);
                end
                else if chs = '4' then
                begin
                        tambah_tayang(tyg,mov,bft);
                end
                else if chs > '4' then
                begin
                        writeln('PERMINTAAN ERROR');
                end
        until chs = '0';
end;

//SUBMENU 2

procedure submenu2(var tyg:array_mov_tayang;bft:integer;var ticket:integer);
var
        jawab:integer;
        i:integer;
begin
        i:=1;
        repeat
                writeln('[*]===============>> Daftar Movie <<===============[*]');
                tampil_jadwal(tyg,bft);
                writeln('0. Exit');
                writeln('---silahkan pilih berdasar urutan pada jadwal---');
                write('Jawaban : ');
                readln(jawab);
                if (jawab<> 0) then
                begin
                        pil_bangku(tyg,jawab,ticket);
                end;
        until jawab = 0;
end;

//SUBMENU 3
procedure submenu3(var data:array_mov_tayang;banyak,sisa:integer);
var
        i,j,ticket:integer;
begin
        for i:=1 to banyak do
        begin
                writeln('Nama Movie : ',data[i].filmt.nama_movie);
                writeln('Sisa Tiket : ',data[i].filmt.tiket-data[i].filmt.sisa);
        end;
        readln;
end;

//MENU UTAMA
var
        arsipmovie: file of array_movie;
        arsiptayang: file of array_mov_tayang;
        pilih:char;
        n,ticket : integer;
        dataMovie : array_movie;
        dataTayang : array_mov_tayang;
        a:integer;
        arsipbanyakdata: file of integer;
begin
        clrscr;
        //Arsip Urutan
        if  FileExists('Data.DAT') then
        begin
                assign(arsipbanyakdata,'Data.DAT');
                reset(arsipbanyakdata);
                Read(arsipbanyakdata,a);
                close(arsipbanyakdata);
        end
        else
        begin
                assign(arsipbanyakdata,'Data.DAT');
                rewrite(arsipbanyakdata);
                Write(arsipbanyakdata,a);
                close(arsipbanyakdata);
        end;
        //Arsip Movie
        if  FileExists('Movie.DAT') then
        begin
                assign(arsipmovie,'Movie.DAT');
                reset(arsipmovie);
                read(arsipmovie,dataMovie);
                close(arsipmovie);
        end
        else
        begin
                assign(arsipmovie,'Movie.DAT');
                rewrite(arsipmovie);
                write(arsipmovie,dataMovie);
                close(arsipmovie);
        end;
        //Arsip Tayang
        if FileExists('Tayang.DAT') then
        begin
                assign(arsiptayang,'Tayang.DAT');
                reset(arsiptayang);
                read(arsiptayang,dataTayang);
                close(arsiptayang);
        end
        else
        begin
                assign(arsiptayang,'Tayang.DAT');
                rewrite(arsiptayang);
                write(arsiptayang,dataTayang);
                close(arsiptayang);
        end;

gotoxy(20,10);writeln('============================= X   APILKASI BIOSKOP   X =============================');

        readln;
        clrscr;
  repeat
        clrscr;
        writeln('                       Daftar Pilihan                       ');
        writeln('               1. Input Movie                               ');
        writeln('               2. Jadwal Tayang                             ');
        writeln('               3. Pembelian                                 ');
        writeln('               4. Sisa Tiket                                ');
        writeln('               5. Daftar Member                             ');
      //writeln('               6. Reset Data                                ');
        writeln('               0. Exit                                      ');
        writeln;
        write('   Pilih Program : ');
        readln(pilih);
         if pilih = '1' then
         begin
                submenu1(dataTayang,dataMovie,n,a);
         end
        else if pilih = '2' then
         begin
                tampil_jadwal(dataTayang,n);
                readln;
         end
        else if pilih = '3' then
         begin
                submenu2(dataTayang,n,ticket);
         end
        else if pilih = '4' then
         begin
                submenu3(dataTayang,a,ticket);
         end
       { else if pilih = '6' then
         begin
                assign(arsipmovie,'Movie.DAT');
                assign(arsiptayang,'Tayang.DAT');
                assign(arsipbanyakdata,'Data.DAT');
                erase(arsipmovie);
                erase(arsiptayang);
                erase(arsipbanyakdata);
                close(arsipmovie);
                close(arsiptayang);
                close(arsipbanyakdata);
         end }
  else if pilih>'4' then
        begin
                writeln('ERROR');
                readln;
        end;
        until (pilih='0');

        assign(arsipmovie,'Movie.DAT');
        rewrite(arsipmovie);
        Write(arsipmovie,dataMovie);
        close(arsipmovie);
        assign(arsiptayang,'Tayang.DAT');
        rewrite(arsiptayang);
        write(arsiptayang,dataTayang);
        close(arsiptayang);
        assign(arsipbanyakdata,'Data.DAT');
        rewrite(arsipbanyakdata);
        write(arsipbanyakdata,a);
        close(arsipbanyakdata);
end.
