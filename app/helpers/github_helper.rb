module GithubHelper

  def language_count(result)
    languages = []

    result[:items].each do |item| 
      languages << item[:language]
    end

    lang_count = Hash.new(0)

    languages.each do |language| 
      if language.present?
        lang_count[language] += 1 
      end
    end

    lang_count
  end
end
