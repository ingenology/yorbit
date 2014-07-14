@if ( Auth::user() )
	<nav class="navigation">
	    <ul>
	        <li>{{ HTML::link('/', 'Home') }}</li>					
	        <li>{{ HTML::link('logout', 'Logout') }}</li>
	    </ul>
	</nav>
@else
	<nav class="navigation">
	    <ul>
	        <li>{{ HTML::link('/', 'Home') }}</li>
	        <li>{{ HTML::link('step-1', 'Create A Map') }}</li>
	    </ul>
	</nav>
@endif