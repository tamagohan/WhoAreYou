# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Item.create(:name => 'twitter読本', :item_type => 1, :image => "/images/twitter_primer.jpg",
            :description => 
"<b>アバターとtwitter</b></br>
</br>
twitter情報をアバターにダウンロードすることで、アバターはあなたの情報を取り込むことができます。</br>
情報の取り込みは「アバターにtwitter情報をダウンロードする」ボタンを押すことで実行できます。</br>
twitter情報を取り込んだアバターはあなたのつぶやきを少しだけ変えてつぶやきます。</br>
</br>
あなたがつぶやき、アバターがそれをとりこむことで、アバターが成長したり、機嫌が変化したりします。（未実装）</br>
</br>
アバターはある一定以上学習が完了すると自分で考えてつぶやきはじめます。（未実装)</br>")

Account.create(
               :login                 => 'admin',
               :password              => "accessjp",
               :password_confirmation => "accessjp",
               :role                  => 0
               )
