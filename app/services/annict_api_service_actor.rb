class AnnictApiServiceActor
  def initialize
    @base_url = "https://api.annict.com/v1/people"
    @access_token = ENV["ANNICT_ACCESS_TOKEN"]
  end

  def import_actor_data(casts)
    # ユニークなactor_idを保持する配列
    unique_actor_ids = casts.map { |cast| cast.person_id }.uniqq
    unique_actor_ids.each do |actor_id|
      puts actor_id
      response = Faraday.get("#{@base_url}", {
        fields: 'id,name,name_en,url,wikipedia_url,twitter_username,birthday',
        per_page: 50,
        filter_ids: actor_id, # actor_idでフィルタリング
        access_token: @access_token
      })
      data = JSON.parse(response.body)
      puts data
      
      create_actor_records(data["people"], actor_id)
    end
  end
  
  private

  # API結果をActorテーブルへ登録する関数
  def create_actor_records(actors, actor_id)
    actors.each do |actor|
      # Actor モデルのレコードを検索し、存在しない場合は初期化
      actor_record = Actor.find_or_initialize_by(person_id: actor["id"])
      # レコードの属性を更新
      unless actor_record.update(
        person_id: actor["id"],
        name: actor["name"],
        name_en: actor["name_en"],
        official_site_url: actor["url"],
        twitter_url: actor["twitter_username"].present? ? "https://twitter.com/#{actor['twitter_username']}" : nil,
        birthday: actor["birthday"]
      )
      puts "Update failed: #{actor_record.errors.full_messages.join(", ")}"
      end
    end
  
  end
end