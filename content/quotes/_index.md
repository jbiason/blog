+++
transparent = false
sort_by = "weight"
paginate_by = 0
title = "Quotes"
+++

<div class="post">
	<h1 class="post-title">{{ section.title }}</h1>

	<ul>
		{% for term in section.pages %}
		<li class="tag-list">
			<a href="{{ term.permalink | safe }}">
				{{ term.title }} 
			</a>
		</li>
		{% endfor %}
	</ul>
</div>
