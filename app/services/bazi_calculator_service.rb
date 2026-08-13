# frozen_string_literal: true

# Service for calculating BaZi (Four Pillars) day master, branch, and Feng Shui Kua number.
class BaziCalculatorService
  STEMS = [
    { en: 'Jia Wood', zh: '甲木', element: 'Wood', polarity: 'Yang' },
    { en: 'Yi Wood', zh: '乙木', element: 'Wood', polarity: 'Yin' },
    { en: 'Bing Fire', zh: '丙火', element: 'Fire', polarity: 'Yang' },
    { en: 'Ding Fire', zh: '丁火', element: 'Fire', polarity: 'Yin' },
    { en: 'Wu Earth', zh: '戊土', element: 'Earth', polarity: 'Yang' },
    { en: 'Ji Earth', zh: '己土', element: 'Earth', polarity: 'Yin' },
    { en: 'Geng Metal', zh: '庚金', element: 'Metal', polarity: 'Yang' },
    { en: 'Xin Metal', zh: '辛金', element: 'Metal', polarity: 'Yin' },
    { en: 'Ren Water', zh: '壬水', element: 'Water', polarity: 'Yang' },
    { en: 'Gui Water', zh: '癸水', element: 'Water', polarity: 'Yin' }
  ].freeze

  BRANCHES = [
    { en: 'Zi Rat', zh: '子鼠', animal: 'Rat', element: 'Water' },
    { en: 'Chou Ox', zh: '丑牛', animal: 'Ox', element: 'Earth' },
    { en: 'Yin Tiger', zh: '寅虎', animal: 'Tiger', element: 'Wood' },
    { en: 'Mao Rabbit', zh: '卯兔', animal: 'Rabbit', element: 'Wood' },
    { en: 'Chen Dragon', zh: '辰龙', animal: 'Dragon', element: 'Earth' },
    { en: 'Si Snake', zh: '巳蛇', animal: 'Snake', element: 'Fire' },
    { en: 'Wu Horse', zh: '午马', animal: 'Horse', element: 'Fire' },
    { en: 'Wei Goat', zh: '未羊', animal: 'Goat', element: 'Earth' },
    { en: 'Shen Monkey', zh: '申猴', animal: 'Monkey', element: 'Metal' },
    { en: 'You Rooster', zh: '酉鸡', animal: 'Rooster', element: 'Metal' },
    { en: 'Xu Dog', zh: '戌狗', animal: 'Dog', element: 'Earth' },
    { en: 'Hai Pig', zh: '亥猪', animal: 'Pig', element: 'Water' }
  ].freeze

  KUA_DIRECTIONS = {
    1 => { group: 'East', sheng_qi: 'SE', tian_yi: 'E', yan_nian: 'S', fu_wei: 'N' },
    2 => { group: 'West', sheng_qi: 'NE', tian_yi: 'W', yan_nian: 'NW', fu_wei: 'SW' },
    3 => { group: 'East', sheng_qi: 'S', tian_yi: 'N', yan_nian: 'SE', fu_wei: 'E' },
    4 => { group: 'East', sheng_qi: 'N', tian_yi: 'S', yan_nian: 'E', fu_wei: 'SE' },
    6 => { group: 'West', sheng_qi: 'W', tian_yi: 'NE', yan_nian: 'SW', fu_wei: 'NW' },
    7 => { group: 'West', sheng_qi: 'NW', tian_yi: 'SW', yan_nian: 'NE', fu_wei: 'W' },
    8 => { group: 'West', sheng_qi: 'SW', tian_yi: 'NW', yan_nian: 'W', fu_wei: 'NE' },
    9 => { group: 'East', sheng_qi: 'E', tian_yi: 'SE', yan_nian: 'N', fu_wei: 'S' }
  }.freeze

  def initialize(birth_date:, gender: 'male')
    @date = birth_date.is_a?(String) ? Date.parse(birth_date) : birth_date
    @gender = gender.to_s.downcase
  end

  def calculate
    day_stem_idx, day_branch_idx = calculate_day_pillar
    day_master = STEMS[day_stem_idx]
    day_branch = BRANCHES[day_branch_idx]
    kua_num = calculate_kua_number

    build_calculation_result(day_master, day_branch, kua_num)
  end

  private

  def build_calculation_result(day_master, day_branch, kua_num)
    {
      birth_date: @date.to_s,
      gender: @gender,
      day_master: format_day_master(day_master),
      day_branch: format_day_branch(day_branch),
      kua_number: kua_num,
      kua_profile: KUA_DIRECTIONS[kua_num],
      today_luck_teaser: generate_luck_teaser(day_master[:element])
    }
  end

  def format_day_master(day_master)
    {
      name: day_master[:en],
      chinese: day_master[:zh],
      element: day_master[:element],
      polarity: day_master[:polarity]
    }
  end

  def format_day_branch(day_branch)
    {
      name: day_branch[:en],
      chinese: day_branch[:zh],
      animal: day_branch[:animal]
    }
  end

  def calculate_day_pillar
    day_index = (@date.jd + 5) % 60
    [day_index % 10, day_index % 12]
  end

  def calculate_kua_number
    year_sum = sum_digits(@date.year)
    @gender == 'male' ? calculate_male_kua(year_sum) : calculate_female_kua(year_sum)
  end

  def calculate_male_kua(year_sum)
    base = @date.year < 2000 ? 8 : 9
    kua = base - year_sum
    kua == 5 ? 2 : kua
  end

  def calculate_female_kua(year_sum)
    offset = @date.year < 2000 ? 5 : 6
    kua = sum_digits(year_sum + offset)
    kua == 5 ? 8 : kua
  end

  def sum_digits(number)
    sum = number.to_s.chars.map(&:to_i).sum
    sum > 9 ? sum_digits(sum) : sum
  end

  def generate_luck_teaser(element)
    score = rand(82..98)
    "Today's Energy Rating for #{element} Day Masters: #{score}% High Potential. Alignment favors strategic decisions."
  end
end
