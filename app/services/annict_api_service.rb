class AnnictApiService
  def initialize
    @base_url = "https://api.annict.com/v1/works"
    @access_token = ENV["ANNICT_ACCESS_TOKEN"]
  end

  def import_anime_data
    start_year = 2024
    end_year = Date.today.year
    seasons = ["spring", "summer", "autumn", "winter"]
    
    (start_year..end_year).each do |year|
      seasons.each do |season|
        puts year
        puts season
        response = Faraday.get("#{@base_url}", {
          fields: "id,title,title_kana,season_name_text,official_site_url,twitter_username,images",
          filter_season: "#{year}-#{season}",
          sort_watchers_count: 'desc',
          per_page: 50,
          access_token: @access_token
        })
        data = JSON.parse(response.body)
        puts data
        next unless data["works"].is_a?(Array)
        
        create_work_records(data["works"])
      end
    end
  end
  
  private

  # API結果をWorkテーブルへ登録する関数
  def create_work_records(works)
    works.each do |work|
      # Work モデルのレコードを検索し、存在しない場合は初期化
      work_record = Work.find_or_initialize_by(annict_id: work["id"])
      # Twitterアカウント画像はprofile_imageにアクセスできないのでheader_logoに置換
      #twitter_data = work.dig("twitter", "mini_avatar_url")
      #if twitter_data
        #header_photo_url = twitter_data.sub('profile_image', 'header_photo')
      #end
      header_photo_url = "https://twitter.com/#{work['twitter_username']}/header_photo"

      # レコードの属性を更新
      work_record.update(
        title: work["title"],
        title_kana: work["title_kana"],
        year: extract_year(work["season_name_text"]),
        season: extract_season(work["season_name_text"]),
        #Twitter,facebook,recommender_urlの前方からnullではないものを画像URLとして採用
        image_url: header_photo_url.presence || work.dig("images", "facebook", "og_image_url").presence || work.dig("images", "recommended_url"),
        official_site_url: work["official_site_url"],
        twitter_url: work["twitter_username"].present? ? "https://twitter.com/#{work['twitter_username']}" : nil,
        annict_id: work["id"],
        syobocal_tid: work["syobocal_tid"]
        )
    end
  end


  def extract_year(season_text)
    # season_textから年を抽出するロジック
     # 文字列から年を抽出するために正規表現を使用
     match = season_text.match(/(\d{4})年/)
     if match
      match[1].to_i  # 年を整数として返す
    else
      nil  # 年が見つからない場合は nil を返す
    end
  end

  def extract_season(season_text)
    # season_textから季節を抽出するロジック
    case season_text
    when /春/
      'spring'
    when /夏/
      'summer'
    when /秋/
      'autumn'
    when /冬/
      'winter'
    else
      nil  # 季節が見つからない場合は nil を返す
    end
  end
end