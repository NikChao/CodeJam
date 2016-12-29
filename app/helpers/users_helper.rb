module UsersHelper

    def gravatar_for(user, size: 80)
        gravatar_id = Digest::MD5::hexdigest(user.tag.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}/?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end

    def get_points(user)
      return Problem.where(id: Solution.where(user: user).where(validity: 1).pluck(:problem_id)).sum(:points) 
    end
end
