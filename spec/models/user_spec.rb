require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワード空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて半角で設定してください')
      end

      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードは、全角では登録できないこと' do
        @user.password = 'ＡＢＣ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて半角で設定してください')
      end

      it 'パスワードは、数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて半角で設定してください')
      end

      it 'ユーザー本名は、名字と名前が空では登録できない' do
        @user.family_name = nil
        @user.first_name =  nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "First name can't be blank")
      end

      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.family_name = 'yamada'
        @user.first_name =  'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください', 'First name 全角文字を使用してください')
      end

      it 'ユーザー本名のフリガナは、名字と名前が空だと登録できない' do
        @user.family_name_kana = nil
        @user.first_name_kana =  nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "First name kana can't be blank")
      end

      it 'ユーザー本名のフリガナは、全角（カタカナ）でないと登録できない' do
        @user.family_name_kana = 'やまだ'
        @user.first_name_kana =  'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カタカナを使用してください', 'First name kana 全角カタカナを使用してください')
      end

      it '生年月日が必須であること' do
        @user.birth = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end