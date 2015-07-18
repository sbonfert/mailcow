<div class="container">
	<h4>
		<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
		Access
	</h4>

	<div class="panel panel-default">
		<div class="panel-heading">Administrators</div>
		<div class="panel-body">
			<form action="/save" method="post">
				<input type="hidden" name="admin_user_now" value="{$username}">

				<div class="form-group">
					<label class="control-label col-sm-2" for="quota">Administrator:</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="admin_user" id="quota" value="{$username}">
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-2" for="admin_pass">Password:</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" name="admin_pass" id="admin_pass" placeholder="Leave blank for no change">
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-2" for="admin_pass2">Password (repeat):</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" name="admin_pass2" id="admin_pass2">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default btn-raised btn-sm">Save changes</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Domain -->
	<div class="panel panel-default">
		<div class="panel-heading">Domain administrators</div>
		<div class="panel-body">
			<div class="table-responsive">
				<table class="table table-striped" id="domainadminstable">
					<thead>
						<tr>
							<th>Username</th>
							<th>Assigned domains</th>
							<th>Active</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						{foreach $domain_admins as $domain_admin}
							<tr>
								<td>{$domain_admin['username']}</td>
								<td>{$domain_admin['domain']}</td>
								<td>{$domain_admin['active']}</td>
								<td><a href="/deteledomainadmin/{$domain_admin['username']}">delete</a> | <a href="/editdomainadmin/{$domain_admin['username']}">edit</a></td>
							</tr>
						{/foreach}
					</tbody>
				</table>
			</div>

			<small>
				<h4>Add domain administrator</h4>
				<form action="/add_domain_admin" class="form-horizontal" role="form" method="post">
					<div class="form-group">
						<label class="control-label col-sm-4" for="username">Username (<code>A-Z</code>, <code>@</code>, <code>-</code>, <code>.</code>).</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="username" id="username" required>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-sm-4" for="name">Assign domains (hold <code>CTRL</code> to select multiple values):</label>
						<div class="col-sm-8">
							<select style="width:50%" name="domain[]" size="5" multiple>
								{foreach $domains as $domain}
									<option value="{$domain}">{$domain}</option>
								{/foreach}
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-sm-4" for="password">Password:</label>
						<div class="col-sm-8">
							<input type="password" class="form-control" name="password" id="password" placeholder="">
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-sm-4" for="password2">Password (repeat):</label>
						<div class="col-sm-8">
						<input type="password" class="form-control" name="password2" id="password2" placeholder="">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-8">
							<div class="checkbox">
							<label><input type="checkbox" name="active" checked> Active</label>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-0 col-sm-8">
							<button type="submit" class="btn btn-default btn-raised btn-sm">Add domain admin</button>
						</div>
					</div>
				</form>
			</small>
		</div>
	</div>

	<!-- Backup -->
	<h4>
		<span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
		Configuration
	</h4>

	<div class="panel panel-default">
		<div class="panel-heading">Backup mail</div>
		<div class="panel-body">
			<form action="/backup_mail" method="post">
				<div class="form-group">
					<label class="control-label col-sm-4" for="location">Location <small>(will be created if missing)</small>:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="location" id="location" value="{return_mailcow_config("backup_location")}">
					</div>
				</div>

				<br>
				<br>

				<div class="clearfix"></div>

				<div class="form-group">
					<label class="control-label col-sm-4" for="runtime">Runtime</label>
					<div class="col-sm-8">
						<select style="width:50%" name="runtime" size="3">
							<option>>hourly</option>
							<option>>daily</option>
							<option>>monthly</option>
						</select>
					</div>
				</div>

				<div class="clearfix"></div>

				<div class="form-group">
					<label class="control-label col-sm-4" for="mailboxes[]">Select mailboxes <small>(hold <code>CTRL</code> to select multiple values)</small>:</label>
					<div class="col-sm-8">
						<select style="width:50%" name="mailboxes[]" size="5" multiple>
							{foreach $mailboxes as $mailbox}
								{* if strpos(file_get_contents({$mc_mbox_backup}) == $mailbox}
									<option value="{$mailbox}" selected>{$mailbox}</option>
								{else}
									<option value="{$mailbox}">{$mailbox}</option>
								{/if *}
								<option value="{$mailbox}">{$mailbox}</option>
							{/foreach}
						</select>
					</div>
				</div>

				<div class="clearfix"></div>

				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-8">
						<div class="checkbox">
							<label>
								<input type="checkbox" name="use_backup" checked> Use backup function
							</label>
						</div>
					</div>
				</div>

				<div class="clearfix"></div>

				<div class="form-group">
					<input type="hidden" name="trigger_backup">
					<div class="col-sm-8">
						<button type="submit" class="btn btn-default btn-raised btn-sm">Save changes</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Dateianhänge -->
	<div class="panel panel-default">
		<div class="panel-heading">Attachments</div>
		<div class="panel-body">
			<form action="/save_attachments" method="post">
				<div class="form-group">
					<p>Provide a list of dangerous file types. Please take care of the formatting.</p>
					<input class="form-control" type="text" id="ext" name="ext" value="{return_mailcow_config("extlist")}">
					<p>
						<pre>
Format: ext1|ext1|ext3
Enter "DISABLED" to disable this feature.</pre>
					</p>

					<div class="radio">
						<label>
							<input type="radio" name="vfilter" id="vfilter_reject_button" value="reject" {if !return_mailcow_config('vfilter')}checked{/if}>
							Reject attachments with a dangerous file extension
						</label>
					</div>

					<div class="radio">
						<label>
							<input type="radio" name="vfilter" id="vfilter_scan_button" value="filter" {return_mailcow_config('vfilter')}>
							Scan attachments with ClamAV and/or upload to VirusTotal
						</label>
					</div>

					<hr>

					<div class="row">
						<div class="col-sm-6">
							<small>
								<h4>ClamAV</h4>

								<div class="checkbox">
									<label>
										<input name="clamavenable" type="checkbox" {return_mailcow_config("cavenable")}>
										Use ClamAV to scan mail
									</label>
								</div>

								<p>

									<ul class="nav nav-pills">
										<li>
											<a href="?av_dl">
												Download quarantined items
												<span class="badge">
													{echo_sys_info("positives")}
												</span>
											</a>
										</li>
									</ul>
								</p>

								<p>Clean directory <code>/opt/vfilter/clamav_positives/</code> to reset counter.</p>
								<p>Senders of infected messages are informed about failed delivery.</p>
							</small>
						</div>

						<div class="col-sm-6">
							<small>
								<h4>VirusTotal Uploader</h4>

								<div class="checkbox">
									<label>
										<input name="virustotalenable" type="checkbox" {return_mailcow_config("vtenable")}>
										Use the "VirusTotal Uploader" feature
									</label>
								</div>

								<p>Scan dangerous attachments via VirusTotal Public API.</p>
								<p><b>File handling and limitations</b> (<a href="https://www.virustotal.com/de/documentation/public-api/" target="_blank">VirusTotal Public API v2.0</a>)</p>

								<ul>
									<li><em>Files up to 200M will be hashed. If a previous scan result was found, it will be attached.</em></li>
									<li><em>Files smaller than 32M will be uploaded if no previous scan result was found.</em></li>
								</ul>

								<div class="checkbox">
									<label>
										<input name="virustotalcheckonly" type="checkbox" {return_mailcow_config("vtupload")}>
										Do <b>not</b> upload files to VirusTotal but check for a previous scan report. This also requires an API key!
									</label>
								</div>

								<label for="vtapikey">VirusTotal API Key (<a href="https://www.virustotal.com/documentation/virustotal-community/#retrieve-api-key" target="_blank">?</a>)</label>

								<p>
									<input class="form-control" id="vtapikey" type="text" name="vtapikey" placeholder="64 characters, alphanumeric" pattern="[a-zA-Z0-9]{64}" value="{return_mailcow_config("vtapikey")}">
								</p>
							</small>
						</div>

						<div class="col-sm-12">
							<h4>Filter Log (newest)</h4>
							<p>
								<pre>{echo_sys_info("vfilterlog", "20")}</pre>
							</p>
						</div>
					</div>

					<br>

					<button type="submit" class="btn btn-default btn-raised btn-sm">Apply</button>
				</div>
			</form>
		</div>
	</div>

	<!-- Blacklist -->
	<div class="panel panel-default">
		<div class="panel-heading">Sender Blacklist</div>
		<div class="panel-body">
			<form action="/save_blacklist" method="post">
				<div class="form-group">
					<p>Specify a list of senders or domains to blacklist access:</p>
					<textarea class="form-control" rows="6" name="sender">{return_mailcow_config("senderaccess")}</textarea>

					<br>

					<button type="submit" class="btn btn-default btn-raised btn-sm">Apply</button>
				</div>
			</form>
		</div>
	</div>

	<!-- Privacy -->
	<div class="panel panel-default">
		<div class="panel-heading">Privacy</div>
		<div class="panel-body">
			<form action="/save_privacy" method="post">
				<div class="form-group">
					<p>This option enables a PCRE table to remove "User-Agent", "X-Enigmail", "X-Mailer", "X-Originating-IP" and replaces "Received: from" headers with localhost/127.0.0.1.</p>
					<div class="checkbox">
						<label>
							<input type="hidden" name="anonymize_">
							<input name="anonymize" type="checkbox" {return_mailcow_config("anonymize")}>
							Anonymize outgoing mail
						</label>
					</div>

					<button type="submit" class="btn btn-default btn-raised btn-sm">Apply</button>
				</div>
			</form>
		</div>
	</div>

	<!-- DKIM -->
	<div class="panel panel-default">
		<div class="panel-heading">DKIM Signing</div>
		<div class="panel-body">
			<p>Default behaviour is to sign with relaxed header and body canonicalization algorithm.</p>
			<p>
				<strong>DKIM signing will not be used when when "Anonymize outgoing mail" is enabled.</strong>
			</p>
			<form action="/save_dkim" method="post">
				<h4>Active keys</h4>
				{opendkim_table()}

				<h4>Add new key</h4>
				<div class="form-group">
					<div class="row">
						<div class="col-md-4">
							<strong>Domain</strong>
							<input class="form-control" id="dkim_domain" name="dkim_domain" placeholder="example.org">
						</div>

						<div class="col-md-4">
							<strong>Selector</strong>
							<input class="form-control" id="dkim_selector" name="dkim_selector" placeholder="default">
						</div>

						<div class="col-md-4">
							<br>
							<button type="submit" class="btn btn-default btn-raised btn-sm">
								<span class="glyphicon glyphicon-plus"></span>
								Add
							</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Message Sizes -->
	<div class="panel panel-default">
		<div class="panel-heading">Message Size</div>
		<div class="panel-body">
			<form action="/save_message_size" class="form-inline" method="post">
				<p>Current message size limitation: <strong>{return_mailcow_config("maxmsgsize")}MB</strong></p>
				<p>This changes values in PHP, Nginx and Postfix. Services will be reloaded.</p>
				<div class="form-group">
					<input type="number" class="form-control" id="maxmsgsize" name="maxmsgsize" placeholder="in MB" min="1" max="250">
				</div>
				<button type="submit" class="btn btn-default btn-raised btn-sm">Set</button>
			</form>
		</div>
	</div>

	<!-- Maintance -->
	<h4>
		<span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span>
		Maintenance
	</h4>

	<div class="panel panel-default">
		<div class="panel-heading">FAQ</div>
		<div class="panel-body">
			<p data-toggle="collapse" style="cursor:help;" data-target="#dnsrecords">
				<strong>DNS Records</strong>
			</p>
			<div id="dnsrecords" class="collapse out">
				<p>Below you see a list of <em>recommended</em> DNS records.</p>
				<p>While some are mandatory for a mail server (A, MX), others are recommended to build a good reputation score (TXT/SPF) or used for auto-configuration of mail clients (A: "autoconfig" and SRV records).</p>
				<p>In this automatically generated DNS zone file snippet, a simple TXT/SPF record is used to only allow THIS server (the MX) to send mail for your domain. Every other server is disallowed ("-all"). Please refer to <a href="http://www.openspf.org/SPF_Record_Syntax" target="_blank">openspf.org</a>.</p>
				<p>It is <strong>highly recommended</strong> to create a DKIM TXT record with the <em>DKIM Signing</em> utility tool above and install the given TXT record to your nameserver, too.</p>

				<pre>
; ================
; Example forward zone file
; ================

[...]
_imaps._tcp         IN SRV     0 1 993 <?php echo $MYHOSTNAME; ?>.
_imap._tcp          IN SRV     0 1 143 <?php echo $MYHOSTNAME; ?>.
_submission._tcp    IN SRV     0 1 587 <?php echo $MYHOSTNAME; ?>.
@                   IN MX 10   <?php echo $MYHOSTNAME_0, "\n"; ?>
@                   IN TXT     "v=spf1 mx -all"
autoconfig          IN A       <?php echo $IP, "\n"; ?>
dav                 IN A       <?php echo $IP, "\n"; ?>
<?php echo str_pad($MYHOSTNAME_0, 20); ?>IN A       <?php echo $IP, "\n"; ?>

; !!!!!!!!!!!!!!!!
; Do not forget to set a PTR record in your Reverse DNS configuration!
; Your IPs PTR should point to <?php echo $MYHOSTNAME, "\n"; ?>
; !!!!!!!!!!!!!!!!</pre>
			</div>

			<p data-toggle="collapse" style="cursor:help;" data-target="#commontasks">
				<strong>Example usage of <em>doveadm</em> for common tasks regarding Dovecot.</strong>
			</p>
			<div id="commontasks" class="collapse out">
				<pre>
; Searching for inbox messages saved in the past 3 days for user "Bob.Cat":
doveadm search -u bob.cat@domain.com mailbox inbox savedsince 2d

; ...or search Bobs inbox for subject "important":
doveadm search -u bob.cat@domain.com mailbox inbox subject important

; Delete Bobs messages older than 100 days?
doveadm expunge -u bob.cat@domain.com mailbox inbox savedbefore 100d

; From Wiki: Move jane's messages - received in September 2011 - from her INBOX into her archive.
doveadm move -u jane Archive/2011/09 mailbox INBOX BEFORE 2011-10-01 SINCE 01-Sep-2011

; Visit http://wiki2.dovecot.org/Tools/Doveadm</pre>
			</div>

			<p data-toggle="collapse" style="cursor:help;" data-target="#changevfiltermsg">
				<strong>VirusTotal message presets</strong>
			</p>
			<div id="changevfiltermsg" class="collapse out">
				<pre>
; The vfilter is installed into /opt/vfilter
; You should not change any file here unless you know what you are doing
;
; Find and edit message presets here:
nano /opt/vfilter/replies</pre>
			</div>

			<p data-toggle="collapse" style="cursor:help;" data-target="#backupdav">
				<strong>Export Cal- and CardDAV data</strong>
			</p>
			<div id="backupdav" class="collapse out">
				<pre>
; mailcow comes with plugins helping to export Cal- and CardDAV data to .vcf and .ics files.
; Each user can export data he has access to.
; You can generate these exports by finding a url to your calendar, and adding ?export at the end of the url. This will automatically trigger a download:
https://dav.<?php echo $MYHOSTNAME_1.$MYHOSTNAME_2; ?>/calendars/you@domain.tld/default?export

; The same procedure for address books:
https://dav.<?php echo $MYHOSTNAME_1.$MYHOSTNAME_2; ?>/addressbooks/you@domain.tld/default?export

; Please use a Cal-/CardDAV client of your choice to find out the URI of self-created calendars and address books.
; Administrators can use MySQL to find a users calendar and address book URI:
mysql --defaults-file=/etc/mysql/debian.cnf mailcow_database_name -e "SELECT uri FROM calendars where principaluri='principals/you@domain.tld';"
mysql --defaults-file=/etc/mysql/debian.cnf mailcow_database_name -e "SELECT uri FROM addressbooks where principaluri='principals/you@domain.tld';"</pre>
			</div>

			<p data-toggle="collapse" style="cursor:help;" data-target="#debugging">
				<strong>Debugging</strong>
			</p>
			<div id="debugging" class="collapse out">
				<pre>
; Pathes to important log files:
/var/log/mail.log
/opt/vfilter/log/vfilter.log
/var/log/syslog
/var/log/nginx/error.log
/var/www/mail/rc/logs/errors
/var/log/php5-fpm.log</pre>
			</div>

		</div>
	</div>

	<!-- System-Information -->
	<div class="panel panel-default">
		<div class="panel-heading">System Information</div>
		<div class="panel-body">
			<p>This is a very simple system information function. Please be aware that a high RAM usage is what you want on a server.</p>
			<div class="row">
				<div class="col-md-6">
					<h4>Disk usage (/var/vmail) - <?php echo_sys_info("maildisk"); ?>%</h4>
					<div class="progress">
		  				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="{echo_sys_info("maildisk")}" aria-valuemin="0" aria-valuemax="100" style="width:{echo_sys_info("maildisk")}%">
		  				</div>
					</div>
				</div>

				<div class="col-md-6">
					<h4>RAM usage - {echo_sys_info("ram")}%</h4>
					<div class="progress">
		  				<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="{echo_sys_info("ram")}" aria-valuemin="0" aria-valuemax="100" style="width:{echo_sys_info("ram")}%">
		  				</div>
					</div>
				</div>
			</div>

			<h4>Mail queue</h4>
			<pre>
{echo_sys_info("mailq")}</pre>
		</div>
	</div>
</div>
