# frozen_string_literal: true

# Service for calculating BaZi (Four Pillars) day master, branch, optional hour branch, and Feng Shui Kua number.
class BaziCalculatorService
  include Constants

  def initialize(birth_date:, gender: nil, birth_time: nil)
    @date = birth_date.is_a?(String) ? Date.parse(birth_date) : birth_date
    @gender = gender.to_s.strip.presence&.downcase
    @birth_time = birth_time.to_s.strip.presence
  end

  def calculate
    day_stem_idx, day_branch_idx = calculate_day_pillar
    day_master = STEMS[day_stem_idx]
    day_branch = BRANCHES[day_branch_idx]
    kua_num = calculate_kua_number
    hour_branch = calculate_hour_branch

    build_calculation_result(day_master, day_branch, kua_num, hour_branch)
  end

  private

  def build_calculation_result(day_master, day_branch, kua_num, hour_branch)
    result = base_calculation_result(day_master, day_branch, kua_num)
    result[:birth_time] = @birth_time if @birth_time.present?
    result[:hour_branch] = format_day_branch(hour_branch) if hour_branch.present?
    result
  end

  def base_calculation_result(day_master, day_branch, kua_num)
    {
      birth_date: @date.to_s,
      gender: @gender || 'unspecified',
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

  def calculate_hour_branch
    return nil if @birth_time.blank?

    parts = @birth_time.split(':').map(&:to_i)
    hour = parts[0] || 0
    min = parts[1] || 0

    total_minutes = hour * 60 + min
    shichen_index = ((total_minutes + 60) / 120) % 12

    BRANCHES[shichen_index]
  end

  def calculate_kua_number
    return nil if @gender.blank? || @gender == 'unspecified'

    year_sum = sum_digits(@date.year)
    @gender == 'female' ? calculate_female_kua(year_sum) : calculate_male_kua(year_sum)
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
