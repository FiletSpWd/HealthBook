require 'rails_helper'

RSpec.feature "Users", type: :feature do

  context "create new user" do
    before(:each) do
      visit new_user_registration_path
      within('form') do
        fill_in 'Имя пользователя для отображения на сайте', with: 'Rika'
        fill_in 'Дата рождения', with: '2000.01.01'
        fill_in 'Пароль (7 знаков и более)', with: '1234567'
        fill_in 'Подтверждение пароля', with: '1234567'
      end
    end
    scenario "should be successful" do
      within('form') do
        fill_in 'E-mail', with: 'test@gmail.com'
      end
      click_button 'Зарегестироваться'
      expect(page).to have_content("Вы успешно зарегистрировались")  
    end
    scenario "should fail" do
      click_button 'Зарегестироваться'
      expect(page).to have_content("сохранение не удалось из-за 1 ошибки")  
    end
  end    
end
